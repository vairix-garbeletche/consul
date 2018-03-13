class Comment < ActiveRecord::Base
  include Flaggable
  include HasPublicAuthor
  include Graphqlable
  include Notifiable
  include Documentable
  documentable max_documents_allowed: 1,
               max_file_size: 3.megabytes,
               accepted_content_types: [ "application/pdf" ]

  COMMENTABLE_TYPES = %w(Debate Proposal Budget::Investment Poll Topic Legislation::Question Legislation::Annotation Legislation::Proposal).freeze
  STATUS = {pending: 1, aproved: 2, disaproved: 3}
  AUTHOR_TYPES = {personal_title: 0, state_organism: 1, organized_society: 2, academy: 3, private_sector: 4}

  acts_as_paranoid column: :hidden_at
  include ActsAsParanoidAliases
  acts_as_votable
  has_ancestry touch: true

  attr_accessor :as_moderator, :as_administrator, :as_organism

  validates :body, presence: true
  validates :user, presence: true

  validates :commentable_type, inclusion: { in: COMMENTABLE_TYPES }

  validate :validate_body_length

  validates :organism, presence: true, if: -> {author_type != AUTHOR_TYPES[:personal_title]}

  belongs_to :commentable, -> { with_hidden }, polymorphic: true, counter_cache: true
  belongs_to :user, -> { with_hidden }

  before_save :calculate_confidence_score

  scope :from_proposals, -> { where(commentable_type: 'Proposal') }
  scope :for_render, -> { with_hidden.includes(user: :organization) }
  scope :aproved, -> { with_hidden.includes(user: :organization).where(status: STATUS[:aproved]) }
  scope :pending_publish_flag, -> { where(status: Comment::STATUS[:pending]) }
  scope :aproved_flag, -> { where(status: Comment::STATUS[:aproved]) }
  scope :disaproved_flag, -> { where(status: Comment::STATUS[:disaproved]) }
  scope :with_visible_author, -> { joins(:user).where("users.hidden_at IS NULL") }
  scope :not_as_admin_or_moderator, -> { where("administrator_id IS NULL").where("moderator_id IS NULL")}
  scope :sort_by_flags, -> { order(flags_count: :desc, updated_at: :desc) }
  scope :public_for_api, -> do
    where(%{(comments.commentable_type = 'Debate' and comments.commentable_id in (?)) or
            (comments.commentable_type = 'Proposal' and comments.commentable_id in (?)) or
            (comments.commentable_type = 'Poll' and comments.commentable_id in (?))},
          Debate.public_for_api.pluck(:id),
          Proposal.public_for_api.pluck(:id),
          Poll.public_for_api.pluck(:id))
  end

  scope :sort_by_most_voted, -> { order(confidence_score: :desc, created_at: :desc) }
  scope :sort_descendants_by_most_voted, -> { order(confidence_score: :desc, created_at: :asc) }

  scope :sort_by_newest, -> { order(created_at: :desc) }
  scope :sort_descendants_by_newest, -> { order(created_at: :desc) }

  scope :sort_by_oldest, -> { order(created_at: :asc) }
  scope :sort_descendants_by_oldest, -> { order(created_at: :asc) }

  after_create :call_after_commented

  def self.build(commentable, user, body, p_id = nil, author_type)
    new commentable: commentable,
        user_id:     user.id,
        body:        body,
        parent_id:   p_id,
        author_type:   author_type
  end

  def self.find_commentable(c_type, c_id)
    c_type.constantize.find(c_id)
  end

  def author_id
    user_id
  end

  def author
    user
  end

  def author=(author)
    self.user = author
  end

  def total_votes
    cached_votes_total
  end

  def total_likes
    cached_votes_up
  end

  def total_dislikes
    cached_votes_down
  end

  def as_administrator?
    administrator_id.present?
  end

  def as_moderator?
    moderator_id.present?
  end

  def as_organism?
    organism.present?
  end

  def after_hide
    commentable_type.constantize.with_hidden.reset_counters(commentable_id, :comments)
  end

  def after_restore
    commentable_type.constantize.with_hidden.reset_counters(commentable_id, :comments)
  end

  def reply?
    !root?
  end

  def call_after_commented
    commentable.try(:after_commented)
  end

  def self.body_max_length
    Setting['comments_body_max_length'].to_i
  end

  def calculate_confidence_score
    self.confidence_score = ScoreCalculator.confidence_score(cached_votes_total,
                                                             cached_votes_up)
  end

  private

    def validate_body_length
      validator = ActiveModel::Validations::LengthValidator.new(
        attributes: :body,
        maximum: Comment.body_max_length)
      validator.validate(self)
    end

end
