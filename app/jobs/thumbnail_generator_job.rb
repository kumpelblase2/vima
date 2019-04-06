class ThumbnailGeneratorJob < ApplicationJob
  queue_as :low_priority

  def perform(*args)
    thumbnail_config = Settings.get_instance
    thumbnail_relative_dir = thumbnail_config.thumbnail_dir
    amount = thumbnail_config.thumbnail_amount || 1

    args.map {|id| Video.find(id) }.group_by(&:library).each do |library,videos|
      library_loc = library.path
      thumb_dir = File.join(library_loc, thumbnail_relative_dir)
      Dir.mkdir thumb_dir unless File.exists? thumb_dir

      videos.each do |video|
        video_loc = video.location
        puts "Generating #{amount} thumbnails for #{video_loc}"
        thumbnails = ImageHelper.generate_thumbnails video_loc, amount, File.join(thumb_dir, video.file_hash + "_%d.jpg")
        video.update(selected_thumbnail: 0, thumbnails: thumbnails)
      end
    end
  end
end
