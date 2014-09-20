# encoding: utf-8

class VacanciesController < ApplicationController
  include InvitesHelper
  include UsersHelper

  add_breadcrumb "Главная", :root_path, :title => "Вернуться на главную"
  add_breadcrumb "Вакансии", "/vakansii-promouterov.html", :title => "Вернуться в базу вакансий"

  def index
    @title = "Вакансии для промоутеров"

    @search = Vacancy.order("created_at DESC, price DESC").search(params[:q])
    if params[:find_job] == "true"
      @vacancies = Vacancy.where("city_id = ? AND (med = ? OR med = ?) AND (gender = ? OR gender = ?) AND start_age <= ? AND finish_age >= ?",
        params[:city], current_user.med, false, current_user.gender, "Не важно", calculate_age(current_user.birth), calculate_age(current_user.birth)).page(params[:page])
    elsif params[:city]
      @vacancies = Vacancy.where(city_id: params[:city]).search(params[:q]).result.order('created_at DESC, price DESC').page(params[:page])

    else
      @vacancies = @search.result.page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vacancies }
    end
  end

  def my_vacancies
    @title = "Мои вакансии"

    add_breadcrumb @title

    @vacancies = initialize_grid(Vacancy, :conditions => ['user_id = ?', current_user.id])

  end

  def replies
    @vacancy = Vacancy.find(params[:id])
    add_breadcrumb "Мои вакансии", "/my-vacancies.html", :title => "Вернуться в мои вакансии"

    @title = "Отклики на вашу вакансию #{@vacancy.name}"
    add_breadcrumb @title

    #поставить отметку о прочтении
    @vacancy.replies.where(:see => false).each do |reply|
      reply.update_attribute(:see, 1)
    end

    @replies = initialize_grid(Reply, :conditions => ['vacancy_id = ?', @vacancy.id])
    render '/replies/show_replies_to'
  end

  def invites
    @vacancy = Vacancy.find(params[:id])
    add_breadcrumb "Мои вакансии", "/my-vacancies.html", :title => "Вернуться в мои вакансии"

    @title = "Отклики на вашу вакансию #{@vacancy.name}"
    add_breadcrumb @title

    #поставить отметку о прочтении
    @vacancy.replies.where(:see => false).each do |reply|
      reply.update_attribute(:see, true)
    end

    @replies = initialize_grid(Reply, :conditions => ['vacancy_id = ?', @vacancy.id])
    render '/replies/show_replies_to'
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
    @vacancy = Vacancy.find(params[:id])

    @title = "#{@vacancy.name} от компании: #{@vacancy.user.name}"
    add_breadcrumb @title

    @vacancies = Vacancy.where(:city_id => @vacancy.city.id).limit(4).order("created_at DESC")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vacancy }
    end
  end

  # GET /vacancies/new
  # GET /vacancies/new.json
  def new
    @vacancy = Vacancy.new
    @countries  = Country.all
    @states = State.all
    @cities   = City.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vacancy }
    end
  end



  # GET /vacancies/1/edit
  def edit
    add_breadcrumb "Мои вакансии", "/my-vacancies.html", :title => "Вернуться в мои вакансии"

    @title = "Изменить вакансию"
    add_breadcrumb @title

    @vacancy = Vacancy.find(params[:id])
    @countries  = Country.all
    @states = State.all
    @cities   = City.all
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    @vacancy = current_user.vacancies.build(params[:vacancy])

    respond_to do |format|
      if @vacancy.save
        invite_promos(@vacancy)
        
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully created.' }
        format.json { render json: @vacancy, status: :created, location: @vacancy }
      else
        format.html { render action: "new" }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vacancies/1
  # PUT /vacancies/1.json
  def update
    @vacancy = Vacancy.find(params[:id])

    respond_to do |format|
      if @vacancy.update_attributes(params[:vacancy])
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1
  # DELETE /vacancies/1.json
  def destroy
    @vacancy = Vacancy.find(params[:id])
    @vacancy.destroy

    respond_to do |format|
      format.html { redirect_to vacancies_url }
      format.json { head :no_content }
    end
  end


  def send_invite

  end

  def send_invite_phone
    
  end
end
