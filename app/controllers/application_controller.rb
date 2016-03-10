class ApplicationController < ActionController::Base

   before_filter :authenticate_user!
   protect_from_forgery with: :exception

   #Para que cuando cerremos sesion redireccione a iniciar sesion
   def after_sign_out_path_for(resource_or_scope)
      login_path
   end

   def after_sign_in_path_for(resource_or_scope)
      home_path
   end

end
