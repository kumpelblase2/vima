task :migrate_1_make_paths_absolute => :environment do
  Video.all.each do |video|
    path = Pathname.new video.location
    unless path.absolute?
      new_path = Pathname.pwd + path
      video.update(location: new_path.cleanpath.to_s)
    end

    new_thumbnail_paths = video.thumbnails.map do |thumbnail|
      path = Pathname.new thumbnail
      if path.absolute?
        thumbnail
      else
        (Pathname.pwd + path).cleanpath.to_s
      end
    end

    video.update(thumbnails: new_thumbnail_paths)
  end
end

task :generate_file_hashes => :environment do
  Video.all.each do |video|
    video_location = video.location
    new_hash = FileHelper.get_file_hash(video_location)
    video.update(file_hash: new_hash)
  end
end
