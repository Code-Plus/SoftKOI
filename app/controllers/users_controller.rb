class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update, :disponible, :noDisponible]
	load_and_authorize_resource

	def index
		@users = User.all
	end

	def new
		@user = User.new
		@type_document = TypeDocument.all
	end

	def new_user
		@user = User.create(user_params)
		if @user.save
			flash[:notice] = "¡Usuario creado satisfactoriamente!"
			render action: 'create'
		else
			respond_to do |format|
				format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
			end
		end
	end

	def update_profile
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to home_path, notice: 'Perfil actualizado correctamente.' }
            format.json { render :index, status: :created, location: @user }
			else
				format.html { render :edit }
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

	def disponible
		@user.disponible!
		redirect_to users_url
	end

	def noDisponible
		@user.noDisponible!
		redirect_to users_url
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def update_sanitized_params
		devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:firstname, :lastname, :email, :phone, :cellphone, :role_id)}
	end

	def user_params
		params.require(:user).permit(
		:document,
		:password,
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
		:state,
		:type_document_id)
	end

end
