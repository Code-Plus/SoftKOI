class SalesController < ApplicationController

	load_and_authorize_resource

	def index
		@sales = Sale.all
	end

	# Estado
	def pago
		@sale.pago!
		redirect_to sales_url
	end


	def show
		set_sale
	end


	# Crear venta, asignar empleado y guardar
	def new
		@sale = Sale.new
		@sale.user_id = current_user.id
		@sale.save
		redirect_to edit_sale_path(@sale)
	end


	# Traer productos y clientes disponibles
	def edit
		set_sale

		populate_products
		populate_customers

		@sale.items.build
		@sale.payments.build

		@custom_customer = Customer.new
	end


	# Filtrar en la tabla de productos
	def update_line_item_options
		set_sale
		populate_products

		@available_products = Product.active_quantity.where("name LIKE ? OR description LIKE ?",
		params[:search][:item_name],
		params[:search][:item_name])

		respond_to do |format|
			format.js { ajax_refresh }
		end
	end


	# Filtrar en la tabla de clientes
	def update_customer_options
		set_sale
		populate_products

		@available_customers = Customer.all.where("document LIKE ?  OR firstname LIKE ?
			OR email LIKE ? OR phone LIKE ?",
			params[:search][:customer_name],
			params[:search][:customer_name],
			params[:search][:customer_name],
			params[:search][:customer_name])

		respond_to do |format|
			format.js { ajax_refresh }
		end
	end


	# Asociar cliente a la venta
	def create_customer_association
		set_sale

		unless @sale.blank? || params[:customer_id].blank?
			@sale.customer_id = params[:customer_id]
			@sale.save
		end

		respond_to do |format|
			format.js { ajax_refresh }
		end
	end


	# Agregar productos a la venta
	def create_line_item
		set_sale
		populate_products

		existing_line_item = Item.where('product_id = ? AND sale_id = ?', params[:product_id], @sale.id).first

		if existing_line_item.blank?
			line_item = Item.new(product_id: params[:product_id], sale_id: params[:sale_id], quantity: params[:quantity])
			line_item.price = line_item.product.price
			line_item.save

			remove_item_from_stock(params[:product_id])
			update_line_item_totals(line_item)
		else
			existing_line_item.quantity += 1
			existing_line_item.save

			remove_item_from_stock(params[:product_id])
			update_line_item_totals(existing_line_item)
		end

		update_totals

		respond_to do |format|
			format.js { ajax_refresh }
		end
	end


	# Aumentar cantidad de un producto asociado
	def add_item
		set_sale
		populate_products

		line_item = Item.where(sale_id: params[:sale_id], product_id: params[:product_id]).first
		line_item.quantity += 1
		line_item.save

		# Llama método que reduce cantidad de stock
		remove_item_from_stock(params[:product_id])
		update_line_item_totals(line_item)

		update_totals

		respond_to do |format|
			format.js { ajax_refresh }
		end
	end


	# Reducir cantidad de un producto asociado o eliminarlo
	def remove_item
		set_sale
		populate_products

		line_item = Item.where(sale_id: params[:sale_id], product_id: params[:product_id]).first
		line_item.quantity -= 1

		if line_item.quantity <= 0
			line_item.destroy
		else
			line_item.save
			update_line_item_totals(line_item)
		end

		# Llama método que devuelve cantidad al stock
		return_item_to_stock(params[:product_id])

		update_totals

		respond_to do |format|
			format.js { ajax_refresh }
		end
	end


	# Crear usuario nuevo
	def create_custom_customer
		set_sale
		populate_products

		custom_customer = Customer.new
		custom_customer.document = params[:custom_customer][:document]
		custom_customer.firstname = params[:custom_customer][:firstname]
		custom_customer.lastname = params[:custom_customer][:lastname]
		custom_customer.phone = params[:custom_customer][:phone]
		custom_customer.cellphone = params[:custom_customer][:cellphone]
		custom_customer.birthday = params[:custom_customer][:birthday]
		custom_customer.email = params[:custom_customer][:email]
		custom_customer.type_document_id = params[:custom_customer][:type_document_id]

		custom_customer.save
		@sale.add_customer(custom_customer.id)

		update_totals

		respond_to do |format|
			format.js { ajax_refresh }
		end
	end


	# Obtener valor total del producto con cantidad + -
	def update_line_item_totals(line_item)
		line_item.total_price = line_item.price * line_item.quantity
		line_item.save
	end


	# Obtener precio de venta con descuento via ajax
	def sale_discount
		@sale = Sale.find(params[:sale_discount][:sale_id])

		@sale.discount = params[:sale_discount][:discount]
		@sale.save

		update_totals

		respond_to do |format|
			format.js { ajax_refresh }
		end
	end


	# Actualizar valores de la venta (valor, valor total, descuento)
  def update_totals

    set_sale

    @sale.amount = 0

    for line_item in @sale.items
      @sale.amount += line_item.total_price
    end

    total_amount = @sale.amount 

    if @sale.discount == 0
      @sale.total_amount = total_amount
    else
      @sale.total_amount -= @sale.discount
    end

    @sale.save
  end


  # Agregar comentarios a la venta
  def add_comment
    set_sale
    @sale.comment = params[:sale_comments][:comment]
    @sale.save

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end


	private

	# Actualizar secciones de la vista de ventas
	def ajax_refresh
		render(file: 'sales/ajax_reload.js.erb')
	end

	# Identificar la venta
	def set_sale
		if @sale.blank?
			if params[:sale_id].blank?
				if params[:search].blank?
					@sale = Sale.find(params[:id])
				else
					@sale = Sale.find(params[:search][:sale_id])
				end
			else
				@sale = Sale.find(params[:sale_id])
			end
		end
	end


	# Poblar productos
	def populate_products
		@available_products = Product.active_quantity
	end


	# Poblar clientes
	def populate_customers
		@available_customers = Customer.all
	end


	# Reducir el stock de un producto
	def remove_item_from_stock(product_id)
    product = Product.find(product_id)
    product.stock -= 1
    product.save
  end


  #Devolver producto a stock
  def return_item_to_stock(product_id)
    product = Product.find(product_id)
    product.stock += 1
    product.save
  end


	# Parametros permitidos para guardar en la venta
	def sale_params
		params.require(:sale).permit(
			:state, :amount,
			:total_amount,
			:discount,
			:limit_date,
			:user_id,
			:comment,
			:customer_id,
		  items_attributes: [:id, :product_id, :price, :total_price, :quantity])
	end

end
