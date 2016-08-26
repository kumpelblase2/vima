Rails.application.routes.draw do
  get '/videos/refresh', to: 'videos#refresh'

  get '/metadata/keys', to: 'metadata#keys'
  get '/metadata', to: 'metadata#all'

  resources :videos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
