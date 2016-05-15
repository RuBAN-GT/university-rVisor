class TestsController < ApplicationController
  add_breadcrumb "Services", :services_path

  before_action :set_service, except: [:all]
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  def all
    add_breadcrumb "My tests", :tests_path

    @tests = Test.where(:user_id => current_user.id).order(:id => :asc)
  end

  def index
    add_breadcrumb "Tests", service_tests_path(@service)

    @tests = Test.where(:user_id => current_user.id, :service_id => params[:service_id]).order(:id => :asc)
  end

  def show
  end

  def new
    add_breadcrumb "Tests", service_tests_path(@service)
    add_breadcrumb "New test", :new_service_test_path

    @test = Test.new
  end

  def edit
  end

  def create
    add_breadcrumb "Tests", service_tests_path(@service)
    add_breadcrumb "New test", :new_service_test_path

    @test = Test.new(test_params)

    @test.user = current_user
    @test.service = @service

    if @test.save
      handle_screens

      redirect_to edit_service_test_path(@service, @test), notice: 'Test was successfully created.'
    else
      render :new
    end
  end

  def update
    data = test_params

    if !!data[:clear_key] == true
      @test.public_key = nil
    end
    data.delete :clear_key

    if @test.update(data)
      handle_screens

      redirect_to edit_service_test_path(@service, @test), notice: 'Test was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @test.destroy

    redirect_to service_tests_path(@service), notice: 'Test was successfully destroyed.'
  end

  private

    def set_test
      @test = Test.find(params[:id])

      add_breadcrumb "Tests", service_tests_path(@service)
      add_breadcrumb @test.title, service_test_path(@service, @test)
    end

    def set_service
      @service = Service.find(params[:service_id])

      add_breadcrumb @service.title, service_path(@service)
    end

    def test_params
      data = params.require(:test).permit(:title, :info, :description, :clear_key, :status, :time_limit, :time_status)
    end

    def handle_screens
      data = {
        :images => [],
        :comments => {}
      }

      unless params[:screens].nil? || params[:screens][:images].nil? || !params[:screens][:images].is_a?(Array)
        data[:images] = params[:screens][:images]

        data[:images].each do |id|
          if tmp = Screen.find(id.to_i)
            if !@test.id.nil? && (@test.status != 'clicks' || @test.screens.length <= 1)
              tmp.test_id = @test.id

              tmp.save
            end
          end
        end
      end

      unless params[:screens].nil? || params[:screens][:comments].nil? || !params[:screens][:comments].is_a?(Hash)
        data[:comments] = params[:screens][:comments]

        data[:comments].each do |key, value|
          if tmp = Screen.find(key.to_i)
            unless @test.id.nil? && tmp.test.id == @test.id
              tmp.comment = value

              tmp.save
            end
          end
        end
      end
    end
end
