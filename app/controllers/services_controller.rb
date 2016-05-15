class ServicesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_service, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Services", :services_path

  def index
    @services = Service.where(:user_id => current_user.id).order(:id => :asc)
  end

  def show
    add_breadcrumb "Show", service_path(@service)
  end

  def new
    add_breadcrumb "New service", :new_service_path

    @service = Service.new
  end

  def edit
    add_breadcrumb "Edit service", edit_service_path(@service)
  end

  def create
    add_breadcrumb "New service", :new_service_path

    @service = Service.new(service_params)

    @service.user = current_user

    if @service.save
      redirect_to edit_service_path(@service), notice: 'Service was successfully created.'
    else
      render :new
    end
  end

  def update
    add_breadcrumb "Edit service", edit_service_path(@service)

    data = service_params

    if !!data[:clear_key] == true
      @service.private_key = nil
    end
    data.delete :clear_key

    if @service.update(data)
      redirect_to edit_service_path(@service), notice: 'Service was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @service.destroy

    redirect_to service_url, notice: 'Service was successfully destroyed.'
  end

  private
    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:title, :info, :clear_key)
    end
end
