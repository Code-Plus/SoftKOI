Rails.application.routes.draw do

  get '/output_products/index'
  get '/output_products/new'
  get '/output_products/show'

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
	resources :input_products

	#Esta ruta pondra los productos disponiblles, buscara en el controlador products el metodo disponible
	put "/product/:id/habilitar", to: "products#disponible"
	#Esta ruta pondra las categorias en noDisponibles, buscara en el controlador de categories el metodo noDisponible
	put "/product/:id/inhabilitar", to: "products#noDisponible"

	#Busca en el controlador el método disponible
	put "/type_product/:id/habilitar", to: "type_products#disponible"
	#Busca en el controlador el método noDisponible.
	put "/type_product/:id/inhabilitar", to: "type_products#noDisponible"

	#Esta ruta pondra las categorias disponibles, buscara en el controlador de categories el metodo disponible
	put "/category/:id/habilitar", to: "categories#disponible"
	#Esta ruta pondra las categorias en noDisponibles, buscara en el controlador de categories el metodo noDisponible
	put "/category/:id/inhabilitar", to: "categories#noDisponible"

end
