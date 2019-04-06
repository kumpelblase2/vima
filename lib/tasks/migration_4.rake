task :migrate_4_create_settings_store => :environment do

  config = Rails.configuration
  thumbnail_config = config.library["thumbnails"]
  thumbnail_relative_dir = thumbnail_config["dir"]
  amount = thumbnail_config["amount"] || 1

  settings = Settings.get_instance
  settings.thumbnail_dir = thumbnail_relative_dir
  settings.thumbnail_amount = amount
  settings.home_video_count = Rails.configuration.library.fetch("home", Hash.new).fetch("videos", 12)
  settings.default_order = Rails.configuration.library.fetch("defaults", Hash.new).fetch("order_by", :name)
  settings.default_order_diration = Rails.configuration.library.fetch("defaults", Hash.new).fetch("order_direction", :asc)
end
