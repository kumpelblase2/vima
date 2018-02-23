task :make_paths_absolute => :environment do
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
