class ContentController < ApplicationController
  def preview

  end

  def video_stream
    video = Video.find(params[:id]) or not_found
    location = video.location
    send_file File.join(Rails.root, location), type: "application/mp4"
  end
end
