class VideoMetadataProvider < MetadataProvider
  def configure(config)
    on_video_load do |video|

    end
  end
end

MetadataProvider.register "VideoMetadata", VideoMetadataProvider