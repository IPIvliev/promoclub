# encoding: utf-8

class VacanciesController < ApplicationController
  add_breadcrumb "Главная", :root_path, :title => "Вернуться на главную"
  add_breadcrumb "Вакансии промоутеров", "/vakansii-promouterov.html", :title => "Вернуться в базу вакансий"

  def index
    @title = "Вакансии промоутеров"

    @vacancies = Vacancy.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vacancies }
    end
  end

  def my
    @title = "Мои вакансии"

    @vacancies = current_user.vacancies.page(params[:page])
    render :template => "/vacancies/index"
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
    @vacancy = Vacancy.find(params[:id])

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
end
