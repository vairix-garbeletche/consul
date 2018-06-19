class LegislationProposalsController < ApplicationController
  include FeatureFlags
  include CommentableActions
  include FlagActions

  before_action :parse_tag_filter, only: :index
  before_action :load_categories, only: [:index, :new, :create, :edit, :map, :summary]
  before_action :load_geozones, only: [:edit, :map, :summary]
  before_action :authenticate_user!, except: [:index, :show, :map, :summary, :show_pdf]
  before_action :load_settings
  before_action :validate_settings, only: [:new, :create]
  before_action :validate_date, only: [:new, :create, :edit]

  feature_flag :proposals

  invisible_captcha only: [:create, :update], honeypot: :subtitle

  has_orders ->(c) { Proposal.is_legislation_proposal.proposals_orders(c.current_user) }, only: :index
  has_orders %w{newest oldest}, only: [:show, :show_pdf]

  before_action :find_proposal, only: [:show, :show_pdf]
  authorize_resource :class => "Proposal"
  before_action :check_permit_edit, only: :update

  helper_method :resource_model, :resource_name
  respond_to :html, :js

  def show
    super
    if @proposal.retired_at.blank?
      @notifications = @proposal.notifications
      @related_contents = Kaminari.paginate_array(@proposal.relationed_contents).page(params[:page]).per(5)
      redirect_to legislation_proposal_path(@proposal), status: :moved_permanently if request.path != legislation_proposal_path(@proposal)
    else
      redirect_to legislation_proposals_path, notice: 'La consulta pública ha sido eliminada.'
    end
  end

  def show_pdf
    super
    @commentable = resource
    @comments = @commentable.comments.order(created_at: :desc)
    set_resource_instance
    @notifications = @proposal.notifications
    @related_contents = Kaminari.paginate_array(@proposal.relationed_contents).page(params[:page]).per(5)

    respond_to do |format|
      format.pdf do
        render pdf: "show", encoding: "UTF-8"
      end
    end
  end

  def create
    @proposal = Proposal.new(proposal_params.merge(author: current_user, is_proposal: false))
    if @proposal.save
      redirect_to share_legislation_proposal_path(@proposal), notice: I18n.t('flash.actions.create.legislation_proposal')
    else
      render :new
    end
  end

  def share
    @proposal = Proposal.find_by_id(params[:id])
    if Setting['proposal_improvement_path'].present?
      @proposal_improvement_path = Setting['proposal_improvement_path']
    end
  end

  private

    def proposal_params
      params.require(:proposal).permit(:title, :question, :summary, :description, :external_url, :video_url, :author_type,
                                       :responsible_name, :tag_list, :geozone_id, :skip_map,
                                       image_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy],
                                       documents_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy],
                                       map_location_attributes: [:latitude, :longitude, :zoom])
    end

    def resource_model
      Proposal
    end

    def load_settings
      @proposal_date_from = Setting.exists?(key: "proposals_start_date") ? Setting.find_by(key: "proposals_start_date").value : nil
      @proposal_date_to = Setting.exists?(key: "proposals_end_date") ? Setting.find_by(key: "proposals_end_date").value : nil
    end

    def validate_settings
      unless Proposal.can_manage? current_user
        redirect_to proposals_path, notice: t('proposals.require_permission')
     end
    end

    def validate_date
      unless Proposal.is_legislation_proposal.in_active_period?
        redirect_to legislation_proposals_path, notice: t('proposals.inactive', date_from: @proposal_date_from, date_to: @proposal_date_to)
      end
    end

    def find_proposal
      @proposal = Proposal.find_by_id(params[:id])
      unless @proposal
        proposal = Proposal.unscoped.find_by_id(params[:id])
        if proposal && !proposal.hidden_at.blank?
          redirect_to legislation_proposals_path, notice: 'La consulta pública que intenta acceder fue eliminada.'
        end
      end
    end

end
