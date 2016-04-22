Rails.application.routes.draw do


	# root_path (/) configurado para el login
	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login"
	end

	#welcome/index como home_path
	get '/home', to: 'welcome#index', as: 'home'
	# Ruta para el ajax de ventas
	get '/sales/customer', to: 'sales#ajax_customer', as: 'ajax_customer'

	# Ruta para el ajax de reservas
  get '/reserves/price_interval', to: 'reserves#Reserve_ajax', as: 'interval_price'


	devise_for :users
   resources :sales
   resources :products
	resources :output_products
	resources :categories
	resources :type_products
	resources :input_products
   resources :reserve_prices
   resources :reserves


	resources :consoles do
   	collection do
   		get 'drop_console'
   	end
   end

	resources :users do
    collection do
      post 'new_user'
    end
  end

	patch "users/:id/update_profile", to: "users#update_profile"

  #Estados de la reserva.
  put "/reserve/:id/activa", to: "reserves#activa"
  put "/reserve/:id/enProceso", to: "reserves#enProceso"
  put "/reserve/:id/finalizada", to: "reserves#finalizada"
  put "/reserve/:id/cancelada", to: "reserves#cancelada"


	#Estados de producto
	put "/product/:id/habilitar", to: "products#disponible"
	put "/product/:id/inhabilitar", to: "products#noDisponible"

	#Estados de tipo de producto
	put "/type_product/:id/habilitar", to: "type_products#disponible"
	put "/type_product/:id/inhabilitar", to: "type_products#noDisponible"

	#Estados de categoria
	put "/category/:id/habilitar", to: "categories#disponible"
	put "/category/:id/inhabilitar", to: "categories#noDisponible"

   #Estados de un usuario
   put "/user/:id/habilitar", to: "users#disponible"
   put "/user/:id/inhabilitar", to: "users#noDisponible"

   #Estados de consola
    put "/console/:id/habilitar", to: "consoles#disponible"
    put "/console/:id/inhabilitar", to: "consoles#noDisponible"
    put "/console/:id/baja", to: "consoles#baja"

end
