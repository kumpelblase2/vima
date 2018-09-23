module PlaylistsHelper
  def self.get_video_after(playlist, current)
    videos = playlist.videos
    current_index = videos.index {|video| video._id == current._id}
    next_index = current_index + 1
    if next_index < videos.size
      videos[next_index]
    end
  end
end
