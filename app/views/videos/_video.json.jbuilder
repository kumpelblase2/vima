json.extract! video, :id, :location, :file_hash, :name

VideoHelper.get_allowed_metadata_keys.each do |key|
  json.set! key, video[key]
end

json.url video_url(video, format: :json)
