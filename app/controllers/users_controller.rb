class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.create(user_params)

		respond_to do |format|
			if @user.save
				format.json { head :no_content }
				format.js { flash[:notice] = "¡Usuario creado satisfactoriamente!" }
			else
				format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @user.update(user_params)
				format.json { head :no_content }
				format.js { flash[:notice] = "¡Usuario actualizado satisfactoriamente!" }
			else
				format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
			end
		end
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(
		:document,
		:encrypted_password,
		:firstname,
		:lastname,
		:email,
		:phone,
		:cellphone,
		:role_id,
		:can_inventory,
	   :can_sales,
	   :can_changes,
	   :can_consoles,
	   :can_customers,
	   :can_diary,
	   :can_payments,
		:state)
	end

end
