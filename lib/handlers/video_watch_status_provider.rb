class VideoWatchStatusProvider < MetadataProvider
  def configure(config)
    on_video_load do |video|
      video[:watched] = false
      video[:watched_times] = 0
      video[:added_date] = DateTime.now.to_date
    end

    on_video_start_play do |video|
      video[:watched] = true
    end

    on_video_finish_play do |video|
      current_times = video[:watched_times] || 0
      video[:watched_times] = current_times + 1
      video[:last_watched] = DateTime.now.to_date
      if video[:first_watched] == nil
        video[:first_watched] = DateTime.now.to_date
      end
    end

    @metadata = [
      Metadata.new("watched", "on_off"),
      Metadata.new("watched_times", "number"),
      Metadata.new("last_watched", "date"),
      Metadata.new("first_watched", "date", true),
      Metadata.new("added_date", "date", true)
    ]
  end
end

MetadataProviderList.instance.register "WatchedStatus", VideoWatchStatusProvider
