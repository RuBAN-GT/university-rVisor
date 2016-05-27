class ResearchController < ApplicationController
  add_breadcrumb "Research", :research_index_path

  before_action :set_test, :only => [:new, :create, :results]

  def index
    @tests = Test.all.order(:service_id => :asc, :id => :asc)
  end

  def new
    @research = Result.new

    add_breadcrumb 'Research', new_research_path(@test)
  end

  def create
    add_breadcrumb 'Research', new_research_path(@test)

    data   = research_params
    polls  = data.delete :poll
    clicks = data.delete :clicks

    @research = Result.new(data)

    @research.test_id = @test.id
    @research.user_id = current_user.id

    if @research.save
      unless polls.nil?
        polls.each do |poll|
          poll = ResultPoll.new(:result_id => @research.id, :screen_id => poll)

          poll.save
        end
      end

      unless clicks.nil?
        clicks.each do |click|
          click = click.split ','

          click = ResultClick.new(:result_id => @research.id, :x => click[0].to_f, :y => click[1].to_f)

          click.save
        end

        @research.test.destroy_heatmap
      end

      redirect_to research_path(@research), notice: 'Result was successfully saved.'
    else
      render :new
    end
  end

  def destroy
    @research = Result.find(params[:id])

    @research.destroy

    redirect_to test_results_path(@research.test), notice: 'Result was successfully deleted.'
  end

  def results
    add_breadcrumb 'Results', test_results_path(@test)
  end

  def show
    @research = Result.find(params[:id])

    add_breadcrumb @research.test.title, test_results_path(@research.test)
    add_breadcrumb 'Result', research_path(@research)
  end

  private

    def research_params
      params.require(:result).permit(:main_comment, :poll => [], :clicks => [])
    end

    def set_test
      @test = Test.find(params[:test_id])

      add_breadcrumb @test.title, test_results_path(@test)
    end
end
