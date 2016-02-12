Rails.application.routes.draw do

	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login" 
  	end

	get '/home', to: 'welcome#index', as: 'home'

    devise_for :user	
end
