json.extract! video, :id, :location, :file_hash, :name

json.thumbnails do
  json.available video.thumbnails.each_with_index.map { |_, i| video_thumbnail_url(video, i) }
  json.selected video.selected_thumbnail
end

MetadataHelper.get_allowed_keys.each do |key|
  json.set! key, video[key]
end

json.url video_url(video, format: :json)
