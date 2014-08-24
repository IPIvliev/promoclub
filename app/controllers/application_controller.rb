class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if current_user.avatar.blank?
    	"/users/#{current_user.id}/edit"
    else
    	"/users/#{current_user.id}"
  	end
  end
end
