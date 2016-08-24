Rails.application.routes.draw do
  resources :videos

  get '/metadata/keys', to: 'metadata#keys'
  get '/metadata', to: 'metadata#all'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
