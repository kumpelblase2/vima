module PlaylistsHelper
  def self.get_video_after(playlist, current)
    return nil unless playlist
    videos = playlist.videos
    current_index = videos.index {|video| video._id == current._id}
    next_index = current_index + 1
    if next_index < videos.size
      videos[next_index]
    end
  end

  def self.get_metadata_display_in_playlist
    playlist_config = Rails.configuration.library["playlist"] || {}
    metadata_to_display = playlist_config["display"] || []
    metadata_to_display.map { |name| MetadataHelper.get_metadata_by_name(name) }
  end
end
