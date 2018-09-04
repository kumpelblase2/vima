json.extract! playlist, :id, :created_at, :updated_at, :name, :query
json.url smart_playlist_url(playlist, format: :json)
json.html_url smart_playlist_url(playlist)
