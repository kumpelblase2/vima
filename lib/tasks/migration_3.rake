task :migrate_3_create_library_store => :environment do
  absolute_path = Pathname.new(Rails.configuration.library["dir"]).realpath
  library = Library.create!({path: absolute_path.to_s})

  Video.all.each do |video|
    video.update({library: library})
  end
end
