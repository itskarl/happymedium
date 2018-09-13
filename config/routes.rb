Rails.application.routes.draw do

  resources :places, except: [:update, :edit, :destroy]
  root 'places#index'


  get 'places/new'
  get 'places/edit'
  get 'places/show'
  get 'places/index'
  get 'index/show'
  get 'index/new'
  get 'index/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
