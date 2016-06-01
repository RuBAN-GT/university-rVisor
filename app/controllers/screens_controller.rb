class ScreensController < ApplicationController
  before_action :authenticate_user!

  def index
    @screens = Screen.all

    render :json => @screens.collect { |p| p.to_jq_upload }.to_json
  end

  def create
    @screen = Screen.new(params.require(:screen).permit(:image))

    if @screen.save!
      respond_to do |format|
        format.js {
          render "create.js"
        }
        format.json {
          render :json => {
            :status => :ok,
            :data => {
              :thumb => @screen.image.thumb.url,
              :url => @screen.image.url
            }
          }
        }
      end
    else
      render :json => {
        :status => :fail,
        :data => {}
      }, :status => 304
    end
  end

  def destroy
    @screen = Screen.find(params[:id])

    @screen.destroy

    respond_to do |format|
      format.js {
        render "destroy.js"
      }
      format.json {
        render :json => {
          :status => :ok,
        }
      }
    end
  end
end
