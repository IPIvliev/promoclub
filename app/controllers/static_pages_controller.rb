# encoding: utf-8

class StaticPagesController < ApplicationController
  add_breadcrumb "Главная", :root_path, :title => "Вернуться на главную"
  include ApplicationHelper


  def index
    profile_finish?

    @promoters = User.where("avatar IS NOT NULL AND city_id IS NOT NULL AND name IS NOT NULL AND phone IS NOT NULL AND status = ?", "promo").order("created_at DESC").limit(16)
    @vacancies = Vacancy.order("created_at DESC").limit(3)
  end

  def about
    profile_finish?

    @title = "О проекте"
    add_breadcrumb @title
  end

  def services
    profile_finish?

    @title = "Услуги"
    add_breadcrumb @title
  end

  def find
    profile_finish?

    @title = "Поиск промоутеров"
    add_breadcrumb "Услуги", "/uslugi.html"
    add_breadcrumb @title
  end

  def job
    profile_finish?

    @title = "Найти работу"
    add_breadcrumb "Услуги", "/uslugi.html"
    add_breadcrumb @title
  end

  def contacts
    profile_finish?

    @title = "Контакты"
    add_breadcrumb @title

    @message = Message.new
  end

  def rabotodateli
    profile_finish?

    @title = "Работодатели - btl-агентства"
    add_breadcrumb @title

    @cities = City.all

    @agents = User.where("avatar IS NOT NULL AND city_id IS NOT NULL AND name IS NOT NULL AND
     phone IS NOT NULL AND status = ?", "agent").order("created_at DESC").page(params[:page])

  end

  def rabotodateli_cities
    profile_finish?

    add_breadcrumb "Работодатели - btl-агентства", "/rabotodateli.html", :title => "Вернуться к общему списку работодателей"    
    city = City.find(params[:city])

    @title = "Город: #{city.name}. Работодатели"
    add_breadcrumb @title

    @cities = City.all

    @agents = User.where("avatar IS NOT NULL AND city_id = ? AND name IS NOT NULL AND
     phone IS NOT NULL AND status = ?", city.id, "agent").order("created_at DESC").page(params[:page])

    render 'rabotodateli'
  end

  def help
    profile_finish?
    
    @title = "Помощь"
    add_breadcrumb @title
  end

end