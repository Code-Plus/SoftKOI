Rails.application.routes.draw do


	# root_path (/) configurado para el login
	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login"
	end

	#welcome/index como home_path
	get '/home', to: 'welcome#index', as: 'home'
	# Ruta para el ajax de ventas
	get '/sales/customer', to: 'sales#ajax_customer', as: 'ajax_customer'

	#Ruta para el ajax de productos
	get '/items/product', to: 'items#ajax_product', as: 'ajax_product'

	# Ruta para el ajax de reservas
  	get '/reservations/price_interval', to: 'reservations#Reserve_ajax', as: 'interval_price'



	devise_for :users
   resources :sales
   resources :products
	resources :customers
	resources :output_products
	resources :categories
	resources :type_products
	resources :input_products
   resources :reserve_prices
   resources :reservations


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
  put "/reservation/:id/activa", to: "reservations#activa"
  put "/reservation/:id/enProceso", to: "reservations#enProceso"
  put "/reservation/:id/finalizada", to: "reservations#finalizada"
  put "/reservation/:id/cancelada", to: "reservations#cancelada"


	#Estados de producto
	put "/product/:id/habilitar", to: "products#disponible"
	put "/product/:id/inhabilitar", to: "products#noDisponible"

	#Estados de tipo de producto
	put "/type_product/:id/habilitar", to: "type_products#disponible"
	put "/type_product/:id/inhabilitar", to: "type_products#noDisponible"

	#Estados de Categoría
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
