require 'streamio-ffmpeg'

class VideoMetadataProvider < MetadataProvider
  def configure(config)
    on_video_load do |video|
      movie = FFMPEG::Movie.new(video.location)
      if movie.valid?
        video[:length] = movie.duration.to_i
        video[:bitrate] = movie.bitrate

        res = ""
        height = movie.height
        if height >= 1080
          res = "1080p"
        elsif height >= 720
          res = "720p"
        elsif height >= 480
          res = "480p"
        else
          res = "SD"
        end
        video[:resolution] = res
      else
        video[:length] = 0
        video[:bitrate] = 0
        video[:resolution] = "Unknown"

        puts "Could not load video metadata"
      end
    end

    @metadata = [
        Metadata.new("length", "numer"),
        Metadata.new("resolution", "select", :values => [ "1080p", "720p", "480p", "SD", "Unknown" ]),
        Metadata.new("bitrate", "number")
    ]
  end
end

MetadataProvider.register "VideoMetadata", VideoMetadataProvider