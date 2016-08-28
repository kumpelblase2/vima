Rails.application.routes.draw do
  get '/videos/refresh', to: 'videos#refresh'

  get '/metadata/keys', to: 'metadata#keys'
  get '/metadata', to: 'metadata#all'

  get '/content/:id/preview', to: 'content#preview'
  get '/content/:id/stream', to: 'content#video_stream'

  resources :videos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
