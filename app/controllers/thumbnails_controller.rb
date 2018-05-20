require "time"

class ThumbnailsController < ApplicationController
  before_action :set_video, only: [:thumbnails, :clear, :generate, :regenerate]

  def thumbnails
    respond_to do |format|
      format.json { render json: @video.thumbnails, status: :ok }
    end
  end

  def thumbnail
    file = params[:file]
    http_cache_forever public: true do
      response.headers["Expires"] = 6.months.from_now.httpdate
      send_file ThumbnailsHelper.full_thumbnail_path(file), type: "application/jpeg"
    end
  end

  def generate
    ThumbnailGeneratorJob.perform_now @video.location
    respond_to do |format|
      format.json { head :no_content, status: :created }
    end
  end

  def clear
    VideoHelper.clear_thumbnails @video
    respond_to do |format|
      format.json { head :no_content, status: :deleted }
    end
  end

  def regenerate
    disable_cache
    VideoHelper.clear_thumbnails @video
    ThumbnailGeneratorJob.perform_now @video.location
    @video = Video.find(@video._id)
  end

  private
    def set_video
      @video = Video.find params[:id]
    end
end
