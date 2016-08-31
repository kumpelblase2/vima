module VideoHelper
  def self.logger
    Rails.logger
  end

  def self.load_video(video)
    checksum = FileHelper.get_file_hash(video)
    logger.info "Checking video #{video}"
    if Video.where(file_hash: checksum).exists?
      logger.info 'Video already exists'
    else
      v = Video.new
      v.location = video
      v.file_hash = checksum
      v.name = get_video_name(video)

      MetadataProvider.run :video_load, v

      v.save!
    end
  end

  def self.get_configured_metadata
    Rails.application.config.library["metadata"] + get_provider_metadata
  end

  def self.get_provider_metadata
    MetadataProvider.enabled_metadata
  end

  def self.get_allowed_metadata_keys
    get_configured_metadata.map { |metadata| metadata.name }
  end

  def self.get_searchable_metadata
    get_configured_metadata.select do |metadata|
      metadata.type == "text"
    end.map { |metadata| metadata.name }
  end

  def self.get_video_name(file)
    File.basename(file, ".mp4")
  end
end
