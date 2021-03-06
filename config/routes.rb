Rails.application.routes.draw do
  get '/videos/refresh', to: 'videos#refresh', as: 'videos_refresh'

  # we need these for different usecases
  # First is to re-order videos (and thus know all of the videos)
  # Second is to add videos from the collection (where we only know the new videos)
  patch '/playlists/:id/videos', to: 'playlists#update_videos', as: 'playlist_videos_update'
  post '/playlists/:id/videos', to: 'playlists#add_videos', as: 'playlist_videos_add'
  get '/playlists/select', to: 'playlists#playlist_select', as: 'playlist_select'

  get '/thumbnails/:id', to: 'thumbnails#thumbnails', as: 'video_thumbnails'
  get '/thumbnails/:id/regenerate', to: 'thumbnails#regenerate', as: 'video_thumbnails_regenerate'
  post '/thumbnails/:id/generate', to: 'thumbnails#generate', as: 'video_thumbnails_generate'
  get '/thumbnail/:id/:thumbnail', to: 'thumbnails#thumbnail', as: 'video_thumbnail'
  delete '/thumbnails/:id', to: 'thumbnails#clear', as: 'video_thumbnails_delete'

  get '/metadata/keys', to: 'metadata#keys'
  get '/metadata', to: 'metadata#all'
  get '/metadata/values/:name', to: 'metadata#values'

  get '/content/:id/preview', to: 'content#preview'
  get '/content/:id/stream', to: 'content#video_stream', as: 'video_stream'

  get '/watch/:id', to: 'watch#index', as: 'watch_video'

  post '/events/:videoId', to: 'event#handle'

  get '/home', to: 'home#home'
  root 'home#index'

  resources :videos
  post '/videos/updateAll', to: 'videos#update_all', as: 'update_multiple'
  resources :playlists
  get '/playlist/:id/delete', to: 'playlists#destroy', as: 'playlists_delete'
  resources :smart_playlists
  get '/smart_playlist/:id/delete', to: 'smart_playlists#destroy', as: 'smart_playlists_delete'

  get '/settings', to: 'settings#index', as: 'settings'
  post '/settings/save', to: 'settings#save', as: 'save_settings'
  delete '/settings/library/:id', to: 'settings#delete_library', as: 'settings_delete_library'
  post '/settings/library', to: 'settings#create_library', as: 'settings_create_library'
end
