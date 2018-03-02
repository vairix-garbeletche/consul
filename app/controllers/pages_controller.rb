class PagesController < ApplicationController
  skip_authorization_check

  def show
    @custom_page = SiteCustomization::Page.published.find_by(slug: params[:id])

    if @custom_page.present?
      render action: :custom_page
    else
      @is_home = true if params[:id] == 'consulta-publica'
      render action: params[:id]
    end
  rescue ActionView::MissingTemplate
    head 404
  end
end
