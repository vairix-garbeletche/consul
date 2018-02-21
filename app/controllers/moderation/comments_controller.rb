class Moderation::CommentsController < Moderation::BaseController
  include ModerateActions

  has_filters %w{pending_flag_review all with_ignored_flag}, only: :index
  has_filters %w{aproved_flag pending_publish_flag disaproved_flag}, only: :publish
  has_orders %w{flags newest}, only: :index

  before_action :load_resources, only: [:index, :moderate]

  load_and_authorize_resource

  def publish
    @comments = Comment.from_proposals.send(@current_filter)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(50)
  end

  def aprove
    comments = Comment.where(id: params["comment_ids"])
    if params[:aprove].present?
      comments.update_all(status: Comment::STATUS[:aproved])
    elsif params[:disaprove].present?
      comments.update_all(status: Comment::STATUS[:disaproved])
    end
    redirect_to publish_moderation_comments_path
  end

  private

    def resource_model
      Comment
    end

    def author_id
      :user_id
    end
end
