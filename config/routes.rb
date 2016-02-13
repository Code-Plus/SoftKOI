Rails.application.routes.draw do

	# root_path (/) configurado para el login
	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login" 
	end

	#welcome/index como home_path
	get '/home', to: 'welcome#index', as: 'home'

	devise_for :users

	resources :products
	resources :categories
	resources :type_products
	
end
