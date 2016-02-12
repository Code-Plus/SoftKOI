Rails.application.routes.draw do

  	resources :products
  	resources :categories
  	resources :type_products
   	devise_for :users


	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login" 
  	end


	get '/home', to: 'welcome#index', as: 'home'


end
