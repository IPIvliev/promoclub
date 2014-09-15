# encoding: UTF-8

class InvitesController < ApplicationController

  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    redirect_to invites_user_path(current_user)
  end
end