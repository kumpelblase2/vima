module ThumbnailsHelper
  def self.full_thumbnail_path(thumbnail_filename)
    config = Rails.configuration
    thumbnail_config = config.library["thumbnails"]
    thumb_dir = File.join(config.library["dir"], thumbnail_config["dir"])
    File.join(thumb_dir, thumbnail_filename)
  end
end
