class ItemsController < ApplicationController

	before_action :set_item, only: [:show, :edit, :update]

	def ajax_product
		@product = Product.find(params[:product])
		respond_to do |format|
			format.json{render json: @product }
		end
	end


	def index
		@items = Item.all
		@products = Product.all
	end

	def edit
	end

	def show
	end

	def create
		@item = current_user.sales.build(item_params)
	end

	def new
		@item = Item.new
	end


	private
	def set_item
		@item= Item.find(params[:id])
	end

	def item_params
		params.require(item).permit(:product_id, :sale_id, :quantity, :price, :total_price)
	end
end
