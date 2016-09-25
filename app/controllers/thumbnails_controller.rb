class ThumbnailsController < ApplicationController
  before_action :set_video, only: [:thumbnails, :thumbnail, :clear, :generate]

  def thumbnails
    respond_to do |format|
      format.json { render json: @video.thumbnails, status: :ok }
    end
  end

  def thumbnail
    number = params[:number].to_i
    thumb = @video.thumbnails[number]
    send_file File.join(Rails.root, thumb), type: "application/jpeg"
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

  private
    def set_video
      @video = Video.find params[:id]
    end
end
