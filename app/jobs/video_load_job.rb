class VideoLoadJob < ApplicationJob
  queue_as :default

  def perform(*args)
    libraries = Library.all.to_a
    found = []

    libraries.each do |library|
      dir = library.path
      Dir.glob("*.mp4", base: dir) do |path|
        file = File.join(dir, path)
        next unless File.file?(file)
        found << { library: library, file: file, checksum: FileHelper.get_file_hash(file) }
      end
    end

    new_videos = VideoHelper.get_unknown_videos(found)
    new_videos.each { |video| VideoHelper.load_video(video[:file], video[:library], video[:checksum]) }
  end
end
