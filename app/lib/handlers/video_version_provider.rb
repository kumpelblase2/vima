class VideoVersionProvider < MetadataProvider
  def configure(config)
    on_video_create do |video|
      video[:version] = 1
    end

    on_video_update do |video|
      video[:version] = (video[:version] || 0) + 1
    end

    @metadata = [
        Metadata.new("version", "number", true, {}, 'desc')
    ]
  end
end

MetadataProviderList.instance.register "VideoVersion", VideoVersionProvider
