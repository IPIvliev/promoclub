# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :configure_devise_params, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user.avatar.blank?
    	"/users/#{current_user.id}/edit"
    else
    	"/users/#{current_user.id}"
  	end
  end

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :status)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "У вас нет доступа"
  end

end
