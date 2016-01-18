class ServicesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :service

  layout "control_panel"

  before_filter do
    add_breadcrumb "control_panel.index", :cp_path, :titled => true
    add_breadcrumb "services.index", :services_path, :titled => true
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to services_path, :alert => I18n.t("structures.services.lost")
  end

  def index
    @services = Service.order("name ASC").all
  end

  def show
    @service = Service.find params[:id]

    add_breadcrumb show_title
  end
  def show_title
    get_title_by_code "services.show", :name => @service.name
  end

  def new
    @service = Service.new

    add_breadcrumb new_title
  end
  def new_title
    get_title_by_code "services.new"
  end

  def create
    @service = Service.new(params[:service])

    @service.public_key = SecureRandom.urlsafe_base64 16
    @service.secret_key = SecureRandom.urlsafe_base64 16

    if @service.save
      redirect_to @service,  flash: { :notice => I18n.t("structures.services.create.ok") }
    else
      render 'new'
    end
  end
  def create_title
    new_title
  end

  def edit
    @service = Service.find(params[:id])

    add_breadcrumb edit_title
  end
  def edit_title
    get_title_by_code "services.edit"
  end

  def update
    @service = Service.find(params[:id])

    if @service.update(params[:service])
      flash[:notice] = I18n.t("structures.services.update.ok")
    end

    render 'edit'
  end
  def update_title
    edit_title
  end

  def destroy
    @service = Service.find(params[:id])

    @service.destroy

    redirect_to services_path, flash: { :notice => I18n.t("structures.services.delete.ok") }
  end

  protected
  def service_params
    params.require(:service).permit(:slug, :name, :info, :owner_id)
  end
end