# encoding: UTF-8

class RepliesController < ApplicationController
  load_and_authorize_resource
  
  def create
    @vacancy = Vacancy.find(params[:reply][:vacancy_id])
    current_user.reply!(@vacancy)

    redirect_to @vacancy
  end

  def destroy
    @reply = Reply.find(params[:id])
    @vacancy = Vacancy.find(@reply.vacancy)
    current_user.unreply!(@vacancy)

    redirect_to @vacancy
  end
end