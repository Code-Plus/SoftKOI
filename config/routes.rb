Rails.application.routes.draw do


	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login" 
  end

  resources :movies
  resources :clothings
  resources :consoles
  resources :genres
  resources :types_consoles
  resources :types_clothings


  devise_for :users

	get '/home', to: 'welcome#index', as: 'home'

end
