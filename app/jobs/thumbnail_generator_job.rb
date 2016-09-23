class ThumbnailGeneratorJob < ApplicationJob
  queue_as :low_priority

  def perform(*args)
    config = Rails.configuration
    thumbnail_config = config.library["thumbnails"]
    if thumbnail_config["generate"]
      thumb_dir = File.join(config.library["dir"], thumbnail_config["dir"])
      Dir.mkdir thumb_dir unless File.exists? thumb_dir

      amount = thumbnail_config["amount"]
      args.each do |video_loc|
        file_hash = FileHelper.get_file_hash(video_loc)
        video = Video.find_by_hash file_hash
        if video
          puts "Generating #{amount} thumbnails for #{video_loc}"
          thumbnails = ImageHelper.generate_thumbnails video_loc, amount, File.join(thumb_dir, file_hash + "_%d.jpg")
          video.thumbnails = thumbnails
          video.selected_thumbnail = 0
          video.save!
        end
      end
    end
  end
end
