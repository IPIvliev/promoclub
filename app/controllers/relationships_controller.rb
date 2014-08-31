# encoding: UTF-8

class RelationshipsController < ApplicationController
  include OpinionsHelper

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)

    # Добавляем единицу к рейтингу пользователя
    rate_factory(@user, 1)

    redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)

    # Удаляем единицу из рейтинга пользователя
    rate_factory(@user, 2)

    redirect_to @user
  end
end