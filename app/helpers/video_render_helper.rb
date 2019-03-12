module VideoRenderHelper
  def thumbnail_path(video)
    video_thumbnail_path(id: video._id.to_s, thumbnail: video.selected_thumbnail || 0)
  end
end
