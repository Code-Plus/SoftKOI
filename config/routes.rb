Rails.application.routes.draw do


  resources :item_coupons
  resources :coupons
	# root_path (/) configurado para el login
	devise_scope :user do
		root to: 'devise/sessions#new' , :as => "login"
	end

	# welcome/index como home_path
	get '/home', to: 'welcome#index', as: 'home'

	# Ajax de productos
	get '/items/product', to: 'items#ajax_product', as: 'ajax_product'

	devise_for :users, :skip => :registration
	resources :customers
	resources :categories
	resources :type_products
	resources :reserve_prices
  resources :events do
    collection do
      post 'create_event'
    end
  end

	resources :reports do
		collection do
			get 'chart'
		end
	end

	resources :output_products do
		collection do
			get 'generate_pdf'
		end
	end

	resources :input_products  do
		collection do
			get 'generate_pdf'
		end
	end


	resources :reservations do
		collection do
			get 'reservations_end'
			get 'generate_pdf'
      get 'ajaxnewconsole'
      get 'ajaxscripts'
      get 'change_state'
      get 'price_interval'
		end
	end

	resources :notifications do
		collection do
			post :read
		end
	end

  resources :payments do
  	collection do
      get 'make_payment'
    end
  end

	resources :sales do
		collection do
			get 'update_line_item_options'
      get 'update_customer_options'
      get 'create_line_item'
      get 'update_totals'
      get 'add_item'
      get 'remove_item'
	    get 'create_customer_association'
      get 'create_custom_item'
      get 'create_custom_customer'
      get 'add_comment'
      post 'sale_discount'
			get 'generate_pdf'
      get 'customer'
		end
	end

	resources :products do
		get 'search'
		collection do
			get 'generate_pdf'
			get 'search'
			get 'products_low'
      get 'change_state'
      get 'ajaxscripts'
      get 'ajaxnewcategory'
		end
	end

	resources :consoles do
		collection do
			get 'drop_console'
		end
	end

	resources :users do
		collection do
			post 'new_user'
			patch 'update_password'
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
