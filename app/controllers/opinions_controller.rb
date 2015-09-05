class OpinionsController < ApplicationController
  include ApplicationHelper
  include OpinionsHelper

  def index
    profile_finish?
    
    @my_opinions = current_user.opinions
  end

  def new
    @opinion = current_user.opinions.build(params[:opinion])

    @opinion.save

    rate_factory(@opinion.user_to, @opinion.rate)

    redirect_to user_path(@opinion.user_to)
  end

  def destroy
    @opinion = Opinion.find(params[:id])

    case @opinion.rate
      when 1
        rate = 2
      when 2
        rate = 1
    end

    rate_factory(@opinion.user_to, rate)

    @opinion.destroy

    redirect_to :back
  end
end
