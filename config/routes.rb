Rails.application.routes.draw do

  resources :itineraries
  resources :events

  resources :users
  root 'pages#home'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
