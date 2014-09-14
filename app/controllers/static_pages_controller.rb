# encoding: utf-8

class StaticPagesController < ApplicationController
  add_breadcrumb "Главная", :root_path, :title => "Вернуться на главную"

  def index
    @promoters = User.where("avatar IS NOT NULL AND city_id IS NOT NULL AND name IS NOT NULL AND phone IS NOT NULL AND status = ?", "promo").order("created_at DESC").limit(16)
    @vacancies = Vacancy.order("created_at DESC").limit(3)
  end

  def about
    @title = "О проекте"
    add_breadcrumb @title
  end

  def services
    @title = "Услуги"
    add_breadcrumb @title
  end

  def find
    @title = "Поиск промоутеров"
    add_breadcrumb "Услуги", "/uslugi.html"
    add_breadcrumb @title
  end

  def job
    @title = "Найти работу"
    add_breadcrumb "Услуги", "/uslugi.html"
    add_breadcrumb @title
  end

  def contacts
    @title = "Контакты"
    add_breadcrumb @title

    @message = Message.new
  end

  def rabotodateli
    @title = "Работодатели - btl-агентства"
    add_breadcrumb @title

    @search = User.where("avatar IS NOT NULL AND city_id IS NOT NULL AND name IS NOT NULL AND phone IS NOT NULL AND status = ?", "agent").search(params[:q])
    @agents = @search.result.order("created_at DESC").page(params[:page])

  end

end