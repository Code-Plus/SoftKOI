Rails.application.routes.draw do

  resources :input_products
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

	#Busca en el controlador el método disponible
	put "/type_product/:id/habilitar", to: "type_product#disponible"
	#Busca en el controlador el método noDisponible.
	put "/type_product/:id/inhabilitar", to: "type_product#noDisponible"

	#Esta ruta pondra las categorias disponibles, buscara en el controlador de categories el metodo disponible
	put "/category/:id/habilitar", to: "categories#disponible"
	#Esta ruta pondra las categorias en noDisponibles, buscara en el controlador de categories el metodo noDisponible
	put "/category/:id/inhabilitar", to: "categories#noDisponible"

end
