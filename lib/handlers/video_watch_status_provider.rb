class VideoWatchStatusProvider < MetadataProvider
  def configure(config)
    on_video_load do |video|
      video[:watched] = false
    end

    on_video_start_play do |video|
      video[:watched] = true
    end
  end
end

MetadataProvider.register "WatchedStatus", VideoWatchStatusProvider