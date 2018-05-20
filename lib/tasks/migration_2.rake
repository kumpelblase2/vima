task :remove_path_from_thumbnails => :environment do
  Video.all.each do |video|
    new_thumbnails = video.thumbnails.map { |thumb| File.basename(thumb) }
    video.update(thumbnails: new_thumbnails)
  end
end
