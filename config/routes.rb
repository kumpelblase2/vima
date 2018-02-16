Rails.application.routes.draw do
  get '/videos/refresh', to: 'videos#refresh'
  get '/videos/list', to: 'videos#list'
  get '/videos/search', to: 'videos#search', as: 'video_search'

  get '/playlists/:id/videos', to: 'playlists#videos'
  post '/playlists/:id/videos', to: 'playlists#add_video'
  delete '/playlists/:id/videos', to: 'playlists#remove_video'

  get '/thumbnails/:id', to: 'thumbnails#thumbnails', as: 'video_thumbnails'
  get '/thumbnails/:id/:number', to: 'thumbnails#thumbnail', as: 'video_thumbnail'
  delete '/thumbnails/:id', to: 'thumbnails#clear', as: 'video_thumbnails_delete'
  post '/thumbnails/:id/generate', to: 'thumbnails#generate', as: 'video_thumbnails_generate'

  get '/metadata/keys', to: 'metadata#keys'
  get '/metadata', to: 'metadata#all'

  get '/content/:id/preview', to: 'content#preview'
  get '/content/:id/stream', to: 'content#video_stream'

  get '/watch/:id', to: 'watch#index'

  get '/home', to: 'home#home'
  root 'home#index'

  resources :videos
  resources :playlists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
