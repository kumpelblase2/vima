json.extract! video, :id, :location, :file_hash, :name, :created_at, :updated_at
json.url video_url(video, format: :json)
