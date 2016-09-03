json.extract! video, :id, :location, :file_hash, :name

MetadataHelper.get_allowed_keys.each do |key|
  json.set! key, video[key]
end

json.url video_url(video, format: :json)
