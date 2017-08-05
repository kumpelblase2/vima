json.extract! playlist, :id, :created_at, :updated_at, :name, :videos
json.url playlist_url(playlist, format: :json)
json.html_url playlist_url(playlist)