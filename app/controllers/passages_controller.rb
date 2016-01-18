class PassagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :passage

  layout "control_panel"

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to tests_path, :alert => "Тест не найден."
  end

  before_filter do
    add_breadcrumb "control_panel.index", :cp_path, :titled => true
    add_breadcrumb "tests.index", :tests_path, :titled => true
  end

  def show
    @passage = Passage.find_by_id params[:id]
  end

  def show_title
    get_title_by_code "passages.show", :name => @passage.test.name
  end

  def show_heatmap
    @passage = Passage.find_by_id params[:passage_id]

    send_file @passage.heatmap, filename: "Heatmap", type: "image/png", disposition: "inline"
  end

  def new
    @test = Test.find params[:test_id]

    @passage = Passage.new

    add_breadcrumb new_title
  end

  def new_title
    get_title_by_code "passages.new", :name => @test.name
  end

  def create
    @test = Test.find params[:test_id]

    params[:passage][:test_id] = params[:test_id]
    params[:passage][:participant_id] = current_user.id

    @passage = Passage.new params[:passage].except(:logs)

    if @passage.save
      redirect_to test_passage_path(@test, @passage), flash: { :notice => I18n.t("structures.passages.create.ok") }
    else
      render 'new'
    end
  end

  def create_title
    new_title
  end

  def destroy
    @passage = Passage.find(params[:id])

    @test = Test.find(params[:test_id])

    @passage.destroy

    redirect_to test_path(@test), flash: { :notice => I18n.t("structures.passages.delete.ok") }
  end

  protected
  def passage_params
    params.require(:passage).permit(:comment, { :clicks => [] })
  end
end