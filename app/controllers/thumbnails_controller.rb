class ThumbnailsController < ApplicationController
  before_action :set_video, only: [:thumbnails, :thumbnail, :clear, :generate, :regenerate]

  def thumbnails
    respond_to do |format|
      format.json { render json: @video.thumbnails, status: :ok }
    end
  end

  def thumbnail
    number = params[:number].to_i
    thumb = @video.thumbnails[number]
    send_file thumb, type: "application/jpeg"
    fresh_when :last_modified => @video.updated_at.utc
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
