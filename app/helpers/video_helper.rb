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

  def self.get_video_name(file)
    File.basename(file, ".mp4")
  end
end
