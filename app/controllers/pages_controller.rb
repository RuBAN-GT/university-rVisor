class PagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :page

  layout "control_panel"

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to pages_path, :alert => I18n.t("structures.pages.lost")
  end

  before_filter do
    add_breadcrumb "control_panel.index", :cp_path, :titled => true
    add_breadcrumb "pages.index", :pages_path, :titled => true
  end

  def index
    @pages = Page.order("title ASC").all
  end

  def show(id = nil?)
    id ||= params[:id]

    @page = Page.find id

    add_breadcrumb show_title
  end

  def show_title
    get_title_by_code(@page.blank? ? "pages.show" : "pages.#{@page.slug}")
  end

  def new
    @page = Page.new

    add_breadcrumb new_title
  end

  def new_title
    get_title_by_code "pages.new"
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      redirect_to @page, flash: { :notice => I18n.t("structures.pages.create.ok") }
    else
      render 'new'
    end
  end

  def create_title
    new_title
  end

  def edit
    @page = Page.find(params[:id])

    add_breadcrumb edit_title
  end

  def edit_title
    get_title_by_code "pages.edit"
  end

  def update
    @page = Page.find(params[:id])

    if @page.update(params[:page])
      flash[:notice] = I18n.t("structures.pages.update.ok")
    end

    render 'edit'
  end

  def update_title
    edit_title
  end

  def destroy
    @page = Page.find(params[:id])

    @page.destroy

    redirect_to pages_path, flash: { :notice => I18n.t("structures.pages.delete.ok") }
  end

  protected
  def page_params
    params.require(:page).permit(:title, :content, :slug)
  end
end