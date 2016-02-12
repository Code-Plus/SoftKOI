Rails.application.routes.draw do

  resources :products
  resources :categories
  resources :type_products
  	root 'welcome#index'
   devise_for :users
  	get 'welcome/index'

end
