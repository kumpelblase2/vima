class ThumbnailsController < ApplicationController
  before_action :set_video, only: [:thumbnails, :thumbnail]

  def thumbnails
    respond_to do |format|
      format.json { render json: @video.thumbnails, status: :ok }
    end
  end

  def thumbnail
    number = params[:number].to_i
    thumb = @video.thumbnails[number]
    send_file File.join(Rails.root, thumb), type: "application/jpeg"
  end

  private
    def set_video
      @video = Video.find params[:id]
    end
end
