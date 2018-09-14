Rails.application.routes.draw do
  resources :locations
  resources :places, except: [:update, :edit, :destroy]
root 'places#index'

  get 'places/index'
  get 'places/new'
  get 'places/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
