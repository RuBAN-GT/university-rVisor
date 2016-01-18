class TestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :test

  layout "control_panel"

  before_filter do
    add_breadcrumb "control_panel.index", :cp_path, :titled => true
    add_breadcrumb "tests.index", :tests_path, :titled => true
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to tests_path, :alert => I18n.t("structures.tests.lost")
  end

  def index
    @tests = Test.order("name ASC").all
  end

  def show
    @test = Test.find params[:id]

    @passages = Passage.where(test_id: @test.id)

    add_breadcrumb show_title
  end

  def show_title
    get_title_by_code "tests.show", :name => @test.name
  end

  def show_heatmap
    @test = Test.find_by_id params[:test_id]

    send_file @test.heatmap, filename: "Heatmap", type: "image/png", disposition: "inline"
  end

  def new
    @test = Test.new

    add_breadcrumb new_title
  end

  def new_title
    get_title_by_code "tests.new"
  end

  def create
    @test = Test.new params[:test]

    if @test.save
      redirect_to @test, flash: { :notice => I18n.t("structures.tests.create.ok") }
    else
      render 'new'
    end
  end

  def create_title
    new_title
  end

  def edit
    @test = Test.find(params[:id])

    add_breadcrumb edit_title
  end

  def edit_title
    get_title_by_code "tests.edit"
  end

  def update
    @test = Test.find(params[:id])

    if @test.update(params[:test])
      flash[:notice] = I18n.t("structures.tests.update.ok")
    end

    render 'edit'
  end

  def update_title
    edit_title
  end

  def destroy
    @test = Test.find(params[:id])

    @test.destroy

    redirect_to tests_path, flash: { :notice => I18n.t("structures.tests.delete.ok") }
  end

  protected
  def test_params
    params.require(:test).permit(
        :name,
        :info,
        :service_id,
        :owner_id,
        :picture,
        :type,
        :domain
    )
  end
end