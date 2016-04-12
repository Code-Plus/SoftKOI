Rails.application.routes.draw do


	# root_path (/) configurado para el login
	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login"
	end

	#welcome/index como home_path
	get '/home', to: 'welcome#index', as: 'home'

	devise_for :users
   resources :sales
   resources :products
	resources :output_products
	resources :categories
	resources :type_products
	resources :input_products
   resources :reserve_prices
   resources :reserves

	resources :customers do
		get :autocomplete_customer_firstname, :on => :collection
	end

	resources :users do
    collection do
      post 'new_user'
    end
  end

  #Estados de la reserva.
  put "/reserves/:id/activa", to: "reserves#activa"
  put "/reserves/:id/enProceso", to: "reserves#enProceso"
  put "/reserves/:id/finalizada", to: "reserves#finalizada"
  put "/reserves/:id/cancelada", to: "reserves#cancelada"

	#Habilitar producto
	put "/product/:id/habilitar", to: "products#disponible"

	#Inhabilitar producto
	put "/product/:id/inhabilitar", to: "products#noDisponible"

	#Habilitar tipo de producto
	put "/type_product/:id/habilitar", to: "type_products#disponible"

	#Inhabilitar tipo de producto
	put "/type_product/:id/inhabilitar", to: "type_products#noDisponible"

	#Habilitar categoria
	put "/category/:id/habilitar", to: "categories#disponible"

	#Inhabilitar categoria
	put "/category/:id/inhabilitar", to: "categories#noDisponible"

   put "/output_product/:id/deBaja", to: "output_products#deBaja"

   #Habilitar un usuario
   put "/user/:id/habilitar", to: "users#disponible"

   #Deshabilitar un usuario
   put "/user/:id/inhabilitar", to: "users#noDisponible"
end
