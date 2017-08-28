class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:account_update , keys: [:name, :age, :gender, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :age, :gender, :email, :password, :password_confirmation, :image) }
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :age, :gender, :email, :password, :password_confirmation, :image, :role_id, :terms) }
  end

	protected

	def after_sign_up_path_for(resource)
    if current_user.admin?
      homes_admin_path
    elsif current_user.prophent?
      prophents_path
    else
      homes_index_path
    end
	end

	def after_sign_in_path_for(resource)
		if current_user.admin?
      homes_admin_path
    elsif current_user.prophent?
      prophents_path
    else
      homes_index_path
    end
	end
end
