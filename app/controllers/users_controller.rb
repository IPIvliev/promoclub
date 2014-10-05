# encoding: utf-8

class UsersController < ApplicationController
	add_breadcrumb "Главная", :root_path, :title => "Вернуться на главную"
	add_breadcrumb "База промоутеров", "/baza-promouterov.html", :title => "Вернуться в базу промоутеров"

  def index
    @title = "База промоутеров"

    @search = User.where("avatar IS NOT NULL AND city_id IS NOT NULL AND name IS NOT NULL AND phone IS NOT NULL AND status = ?", "promo").search(params[:q])
    if params[:city]
      @promoters = User.where(city_id: params[:city], status: "promo").search(params[:q]).result.order('rate DESC, created_at DESC').page(params[:page])
    else
      @promoters = @search.result.order('rate DESC, created_at DESC').page(params[:page])
    end
  end

  def following
    @title = "Вы добавили в избранное"
    add_breadcrumb @title

    @promoter = User.find(params[:id])
    @users = @promoter.followed_users
    render 'show_follow'
  end

  def followers
    @title = "Вас добавили в избранное"
    add_breadcrumb @title


    @promoter = User.find(params[:id])
    @users = @promoter.followers
    render 'show_follow'
  end

  def replies
    @title = "Ваши отклики на вакансии"
    add_breadcrumb @title

    @promoter = User.find(params[:id])
    @replies = initialize_grid(Reply, :conditions => ['user_id = ?', @promoter.id])
    render '/replies/show_replies'
  end

  def invites
    @title = "Отправленные вам приглашения"
    add_breadcrumb @title

    @promoter = User.find(params[:id])
    @invites = initialize_grid(Invite, :conditions => ['user_to_id = ?', @promoter.id])

    #поставить отметку о прочтении
    @promoter.invites_to_me.where(:see => false).each do |invite|
      invite.update_attribute(:see, true)
    end

    render '/invites/show_invites_to_me'
  end

	def show
		@promoter = User.find(params[:id])
    @newopinion = Opinion.new

    @promoters = User.where("id != ? AND avatar IS NOT NULL AND city_id = ? AND status = ?", @promoter.id, @promoter.city.id, "promo").limit(4).order('rate DESC, created_at DESC')
    @agents = User.where("id != ? AND avatar IS NOT NULL AND city_id = ? AND status = ?", @promoter.id, @promoter.city.id, "agent").limit(4).order('rate DESC, created_at DESC')

		@title = "#{@promoter.name} #{@promoter.surname}"
    add_breadcrumb @title
	end

	def edit
		@user = User.find(params[:id])

    if current_user && current_user == @user
      @countries  = Country.all
      @states = State.all
      @cities   = City.all
    else
      redirect_to root_path
    end
	end

  def update_states
    # updates artists and songs based on genre selected
    country = Country.find(params[:country_id])
    # map to name and id for use in our options_for_select
    @states = country.states.map{|a| [a.name, a.id]}
    @cities   = country.cities.map{|s| [s.name, s.id]}
  end

  def update_cities
    # updates songs based on artist selected
    state = State.find(params[:state_id])
    @cities = state.cities.map{|s| [s.name, s.id]}
  end

def dynamic_cities
    @cities = City.find_all_by_state_id(params[:id])

    respond_to do |format|

      format.js          

    end
end


  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])

        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

end
