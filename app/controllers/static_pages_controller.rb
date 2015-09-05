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

    @page_title = "О проекте"
    @page_description = "Информация о проекте Клуб Промоутеров. Для чего нужнен проект по поиску промоутеров?"

    add_breadcrumb @page_title
  end

  def public
    profile_finish?

    @page_title = "Пользовательское соглашение"
    @page_description = 'Публичная офферта об использовании проекта Клуб Промоутеров'

    add_breadcrumb @page_title
  end  

  def services
    profile_finish?

    @page_title = "Услуги"
    @page_description = 'Услуги по поиску персонала на промо акции и подбору рекламных агенств'
    @page_keywords    = 'рекламные агенства, btl акции, временная работы, работа промоутером, поиск промоутеров, семплинг, рекламные услуги'

    add_breadcrumb @page_title
  end

  def find
    profile_finish?

    @page_title = "Поиск промоутеров"
    @page_description = 'Найти промоутера для организации промо акции в вашем рекламном агенстве.'
    @page_keywords    = 'промоутеры, база промоутеров, найти промоутера, совершеннолетние промоутеры, промоутер модельной внешности, телефоны промоутеров'

    add_breadcrumb "Услуги", "/uslugi.html"
    add_breadcrumb @page_title
  end

  def job
    profile_finish?

    @page_title = "Найти временную работу промоутером"
    @page_description = 'Вакансии рекламных агенств для тех, кто ищет временную работу промоутером.'
    @page_keywords    = 'работа промоутером, промоутер с 16 лет, работа для несовершеннолетних, временная работа, работа для студентов, работа для школьников'

    add_breadcrumb "Услуги", "/uslugi.html"
    add_breadcrumb @page_title
  end

  def contacts
    profile_finish?

    @page_title = "Контакты"
    @page_description = 'У вас есть вопросы по работе нашего сервиса? Задавайте!'
    @page_keywords    = 'вопросы по сервису, сервис, Клуб Промоутеров, временная работа, рекламная акция, организация btl'

    add_breadcrumb @page_title

    @message = Message.new
  end

  def rabotodateli
    profile_finish?

    @page_title = "Работодатели - btl-агентства"
    @page_description = 'Рекламные агенства по России, которые занимаются организацией промо акций'
    @page_keywords    = 'промо агенства, рекламное агенство, btl, btl-агентства, промо, рекламные компании, промоушинг'

    add_breadcrumb @page_title

    @cities = City.all

    @agents = User.where("avatar IS NOT NULL AND city_id IS NOT NULL AND name IS NOT NULL AND
     phone IS NOT NULL AND status = ?", "agent").order("created_at DESC").page(params[:page])

  end

  def rabotodateli_cities
    profile_finish?

    add_breadcrumb "Работодатели - btl-агентства", "/rabotodateli.html", :title => "Вернуться к общему списку работодателей"    
    city = City.find(params[:city])

    @page_title = "Рекламное агентство. Город: #{city.name}"
    @page_description = "Все рекламные агенства в городе #{city.name}"
    @page_keywords    = "рекламное агенство #{city.name}, реклама, промо агенство, btl #{city.name}, промоакция, промо, рекламная акция, дегустация продуктов, btl акция организовать"

    add_breadcrumb @page_title

    @cities = City.all

    @agents = User.where("avatar IS NOT NULL AND city_id = ? AND name IS NOT NULL AND
     phone IS NOT NULL AND status = ?", city.id, "agent").order("created_at DESC").page(params[:page])

    render 'rabotodateli'
  end

  def help
    profile_finish?
    
    @page_title = "Помощь"
    @page_description = 'FAQ по использованию сервиса Клуб Промоутеров'
    @page_keywords    = 'организация btl, найти промоутеров, телефоны промоутеров, faq btl, промоагенства, база данных, контакты промоагенств'

    add_breadcrumb @page_title
  end

end