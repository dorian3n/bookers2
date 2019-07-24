class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	before_action :authenticate_user!, except: [:top, :about]

	def after_sign_in_path_for(resource)
		user_path(current_user)  # ログイン後に遷移するpathを設定
	end

	def after_sign_out_path_for(resource)
		root_path
	end
	
 	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name , :email, :password])
		devise_parameter_sanitizer.permit(:log_in, keys: [:name, :password])
	end
end
