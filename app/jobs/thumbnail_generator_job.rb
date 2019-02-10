class ThumbnailGeneratorJob < ApplicationJob
  queue_as :low_priority

  def perform(*args)
    config = Rails.configuration
    thumbnail_config = config.library["thumbnails"]
    thumb_dir = File.join(config.library["dir"], thumbnail_config["dir"])
    Dir.mkdir thumb_dir unless File.exists? thumb_dir

    amount = thumbnail_config["amount"] || 1
    args.each do |video_loc|
      file_hash = FileHelper.get_file_hash(video_loc)
      video = Video.find_by_hash file_hash
      if video
        puts "Generating #{amount} thumbnails for #{video_loc}"
        thumbnails = ImageHelper.generate_thumbnails video_loc, amount, File.join(thumb_dir, file_hash + "_%d.jpg")
        thumbnails = thumbnails.map { |file| File.basename(file) }
        video.update(selected_thumbnail: 0, thumbnails: thumbnails)
      end
    end
  end
end
