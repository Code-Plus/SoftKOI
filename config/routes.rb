Rails.application.routes.draw do

<<<<<<< HEAD
	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login" 
  	end
=======
  resources :movies
  resources :clothings
  resources :consoles
  resources :genres
  resources :types_consoles
  resources :types_clothings
  	root 'welcome#index'
   devise_for :users
  	get 'welcome/index'
>>>>>>> c95980a9594eaba21bd3252c6562d55a0fc88c0c

	get '/home', to: 'welcome#index', as: 'home'

    devise_for :user	
end
