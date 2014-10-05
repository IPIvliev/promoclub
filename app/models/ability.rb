# encoding: UTF-8

class Ability 
  include CanCan::Ability 

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.status = "admin" # Admin user
      can :manage, :all
    else # Non-admin user
      flash[:danger] = "У вас не доступа."
      redirect_to root_path
    end
  end

end 