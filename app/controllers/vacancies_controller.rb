# encoding: utf-8

class VacanciesController < ApplicationController
  include InvitesHelper
  include UsersHelper
  include ApplicationHelper

  add_breadcrumb "Главная", :root_path, :title => "Вернуться на главную"
  add_breadcrumb "Вакансии", "/vakansii-promouterov.html", :title => "Вернуться в базу вакансий"

  def index
    profile_finish?

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

  end

  def my_vacancies
    profile_finish?

    @title = "Мои вакансии"

    add_breadcrumb @title

    @vacancies = initialize_grid(Vacancy, :conditions => ['user_id = ?', current_user.id],
                  order: 'created_at',
                  order_direction: 'desc',
                  per_page: 10)

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

  def sms_invites
    @vacancy = Vacancy.find(params[:id])
    @count = new_sms_count(@vacancy)

    if Settings.sms_cost == "true" && Settings.status == "production"
      @cost = new_sms_cost(@vacancy)
      if @cost <= current_user.pocket
        if sms_invite_promos(@vacancy)
          pay(@cost)
          flash[:success] = "Вы успешно отправили #{@count} sms на общую сумму #{@cost} руб."
          redirect_to '/my-vacancies.html'
        else
          flash[:danger] = "Произошла непредвиденна ошибка в отправке sms.
           <a href='#'' data-toggle='modal' data-target='#letter'>Свяжитесь с администратором сервиса</a>".html_safe
          redirect_to '/my-vacancies.html'
        end
      else
        flash[:danger] = "На вашем счёте недостаточно средств для отправки sms уведомления всем подходящим
          промоутерам. Рекомендуем Вам <strong><a href='/users/#{current_user.id}/payments' class='red'>пополнить счёт</a></strong>.".html_safe
        redirect_to '/my-vacancies.html'
      end
    else
      sms_invite_promos(@vacancy)
      flash[:success] = "Вы успешно отправили #{@count} sms."
      redirect_to '/my-vacancies.html'
    end

  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
    profile_finish?

    @vacancy = Vacancy.find(params[:id])

    @title = "#{@vacancy.name} от компании: #{@vacancy.user.name}"
    add_breadcrumb @title

    @vacancies = Vacancy.where("id != ? AND city_id = ?", @vacancy.id, @vacancy.city.id).limit(4).order("created_at DESC")

  end

  # GET /vacancies/new
  # GET /vacancies/new.json
  def new
    profile_finish?

    if current_user && current_user.status == "agent"
      @vacancy = Vacancy.new
      @countries  = Country.all
      @states = State.all
      @cities   = City.all

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @vacancy }
      end
    else
      root_path
    end
  end



  # GET /vacancies/1/edit
  def edit
    profile_finish?

    add_breadcrumb "Мои вакансии", "/my-vacancies.html", :title => "Вернуться в мои вакансии"

    @title = "Изменить вакансию"
    add_breadcrumb @title

    @vacancy = Vacancy.find(params[:id])

    if current_user && current_user == @vacancy.user
      @countries  = Country.all
      @states = State.all
      @cities   = City.all
    else
      redirect_to root_path
    end
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    if Settings.vacancy_cost == "true" && Settings.status == "production"
      if Settings.vacancy_price.to_i <= current_user.pocket.to_i
        @vacancy = current_user.vacancies.build(params[:vacancy])
      else
        flash[:danger] = "На вашем счёте недостаточно средств для создания вакансии.
          Рекомендуем Вам <strong>пополнить счёт</strong>.".html_safe
        return redirect_to payments_user_path(current_user)
      end
    else 
      @vacancy = current_user.vacancies.build(params[:vacancy])
    end


    if @vacancy.save
      if Settings.vacancy_cost == "true" && Settings.status == "production"
        pay(Settings.vacancy_price.to_i)
        invite_promos(@vacancy)

        flash[:success] = "Вы успешно создали вакансию. Стоимость услуги составила #{Settings.vacancy_price} руб."
        redirect_to @vacancy
      else
        invite_promos(@vacancy)
        
        flash[:success] = "Вы успешно создали вакансию."
        redirect_to @vacancy
      end

    else
      flash[:danger] = "Произошла ошибка при создании вакансии. Если у вас не получается исправить ошибку, то 
           <a href='#'' data-toggle='modal' data-target='#letter'>свяжитесь с администратором сервиса</a>".html_safe
      render action: "new"
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
