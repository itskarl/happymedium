Rails.application.routes.draw do

  get 'sessions/new'
  resources :itineraries
  get 'itineraries/:id' => 'itineraries#show', as: 'itinerary_show'
  resources :events

  resources :users
  root 'pages#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
