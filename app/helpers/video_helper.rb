module VideoHelper
  def self.logger
    Rails.logger
  end

  def self.get_unknown_videos(videos)
    checksums = videos.map { |elem| elem[:checksum] }
    found = Video.where(:file_hash.in => checksums).distinct(:file_hash)
    videos.reject { |elem| found.include? elem[:checksum] }
  end

  def self.load_video(video_location, library, checksum = nil)
    checksum ||= FileHelper.get_file_hash(video_location)
    logger.debug "Checking video #{video_location}"
    if Video.where(file_hash: checksum).exists?
      logger.debug 'Video already exists'
    else
      v = Video.new
      v.location = video_location
      v.file_hash = checksum
      v.name = get_video_name(video_location)
      v.library = library

      MetadataProviderList.instance.run :video_create, v, false
      MetadataHelper.apply_defaults(v)
      MetadataProviderList.instance.run :video_load, v, false

      v.save!

      generate_thumbnails v
    end
  end

  def self.get_video_name(file)
    File.basename(file, ".mp4")
  end

  def self.generate_thumbnails(video)
    ThumbnailGeneratorJob.perform_later video.id.to_s
  end

  def self.clear_thumbnails(video)
    video.thumbnails.each do |thumb|
      begin
        File.delete thumb
      rescue Exception => _
      end
    end

    video.thumbnails = []
    video.save!
  end

  def self.ordering_options(name, selected, default_dir, current_ordering)
    opposite_dir = if current_ordering == 'asc' then 'desc' else 'asc' end
    new_dir = if selected then opposite_dir else default_dir end
    { order: name, dir: new_dir }
  end
end
