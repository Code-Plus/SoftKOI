Rails.application.routes.draw do

  resources :customers
	# root_path (/) configurado para el login
	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login"
	end

	#welcome/index como home_path
	get '/home', to: 'welcome#index', as: 'home'

	devise_for :users
   resources :products
	resources :output_products
	resources :categories
	resources :type_products
	resources :input_products

	#Pone los productos disponiblles
	put "/product/:id/habilitar", to: "products#disponible"

	#Pone los prodcutos en noDisponibles
	put "/product/:id/inhabilitar", to: "products#noDisponible"

	put "/output_product/:id/deBaja", to: "output_products#deBaja"

	#Busca en el controlador el método disponible
	put "/type_product/:id/habilitar", to: "type_products#disponible"

	#Busca en el controlador el método noDisponible.
	put "/type_product/:id/inhabilitar", to: "type_products#noDisponible"

	#Pone las categorias disponibles
	put "/category/:id/habilitar", to: "categories#disponible"

	#Pone las categorias en noDisponibles
	put "/category/:id/inhabilitar", to: "categories#noDisponible"
end
