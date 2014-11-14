# encoding: UTF-8

class InvitesController < ApplicationController
	load_and_authorize_resource

  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    redirect_to invites_user_path(current_user)
  end
end