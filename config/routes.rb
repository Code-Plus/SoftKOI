Rails.application.routes.draw do

  resources :genres
  resources :types_consoles
  resources :types_clothings
  	root 'welcome#index'
   devise_for :users
  	get 'welcome/index'

end
