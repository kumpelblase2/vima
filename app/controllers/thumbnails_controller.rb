require "time"

class ThumbnailsController < ApplicationController
  before_action :set_video, only: [:thumbnails, :clear, :generate, :regenerate, :thumbnail]

  def thumbnails
    respond_to do |format|
      format.json { render json: @video.thumbnails, status: :ok }
    end
  end

  def thumbnail
    thumbnail_number = params[:thumbnail].to_i
    fresh_when @video
    send_file @video.thumbnails[thumbnail_number], type: "application/jpeg"
  end

  def generate
    ThumbnailGeneratorJob.perform_now @video.id.to_s
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
    ThumbnailGeneratorJob.perform_now @video.id.to_s
    @video = Video.find(@video._id)
  end

  private
    def set_video
      @video = Video.find params[:id]
    end
end
