class ApplicationController < ActionController::Base

  # Custom layout for Devise
  layout :layout_by_resource
  # Route protection
  before_filter :authenticate_user!

  after_filter { flash.discard if request.xhr? }

  protect_from_forgery with: :exception
  before_filter :update_sanitized_params, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to home_path, :alert => exception.message }
    end
  end

  # Cerremos sesión redireccione a iniciar sesion
  def after_sign_out_path_for(resource_or_scope)
    login_path
  end

  def after_sign_in_path_for(resource_or_scope)
    home_path
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:document, :state ,:password, :firstname, :lastname, :email, :phone, :cellphone, :role_id)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:document,:state, :password, :firstname, :lastname, :email, :phone, :cellphone, :role_id, :current_password)}
  end

  protected
  def layout_by_resource
    if devise_controller? && resource_name == :user
      "devise/sessions"
    else
      "application"
    end
  end

end
