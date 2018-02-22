module VideoHelper
  def self.logger
    Rails.logger
  end

  def self.get_unknown_videos(videos)
    video_checksum_map = videos.map {|video| { file: video, checksum: FileHelper.get_file_hash(video)}}
    checksums = video_checksum_map.map { |elem| elem[:checksum] }
    found = Video.where(:file_hash.in => checksums).distinct(:file_hash)
    video_checksum_map.reject { |elem| found.include? elem[:checksum] }.map { |elem| elem[:file] }
  end

  def self.load_video(video)
    checksum = FileHelper.get_file_hash(video)
    logger.debug "Checking video #{video}"
    if Video.where(file_hash: checksum).exists?
      logger.debug 'Video already exists'
    else
      v = Video.new
      v.location = video
      v.file_hash = checksum
      v.name = get_video_name(video)

      MetadataProviderList.instance.run :video_create, v
      MetadataHelper.apply_defaults(v)
      MetadataProviderList.instance.run :video_load, v

      v.save!

      generate_thumbnails video
    end
  end

  def self.get_video_name(file)
    File.basename(file, ".mp4")
  end

  def self.generate_thumbnails file
    ThumbnailGeneratorJob.perform_later file
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
