class VideoWatchStatusProvider < MetadataProvider
  def configure(config)
    on_video_load do |video|
      video[:watched] = false
      video[:watched_times] = 0
      video[:added_date] = DateTime.now
    end

    on_video_start_play do |video|
      video[:watched] = true
    end

    on_video_finish_play do |video|
      current_times = video[:watched_times] || 0
      video[:watched_times] = current_times + 1
      video[:last_watched] = DateTime.now
      if video[:first_watched] == nil
        video[:first_watched] = DateTime.now
      end
      video[:last_watch_progress] = 0
    end

    on_video_watch_progress do |video, info|
      video[:last_watch_progress] = info["current_time"].to_i
    end

    @metadata = [
      Metadata.new("watched", "on_off"),
      Metadata.new("watched_times", "number"),
      Metadata.new("last_watched", "date", false, {}, 'desc'),
      Metadata.new("first_watched", "date", true),
      Metadata.new("added_date", "date", true,  {}, 'desc'),
      Metadata.new("last_watch_progress", "duration", true, {}, 'desc')
    ]
  end
end

MetadataProviderList.instance.register "WatchedStatus", VideoWatchStatusProvider
