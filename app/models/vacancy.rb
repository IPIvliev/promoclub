# encoding: utf-8

class Vacancy < ActiveRecord::Base
  include VacanciesHelper
  include InvitesHelper

  attr_accessible :name, :amount, :country_id, :state_id, :city_id, :description, :finish_date, :med, :price,
                  :start_date, :gender, :start_age, :finish_age

  belongs_to :user
  belongs_to :city
  belongs_to :country

  has_many :replies, :dependent => :destroy
  has_many :invites, :dependent => :destroy
  has_many :sms_invites

  paginates_per 7

  # Отправка письма после создания вакансии
  after_create :send_info_mail
  after_create :add_to_social
  after_create :send_sms_to_promoters

  private

  def add_to_social

    @title = self.name
    @text = "#{@title} http://allpromoters.ru/vacancies/#{self.id} #промоутеры #реклама"

    SocialPoster.write(:vk, @text, nil, from_group: 1, owner_id: '-80069050')
    SocialPoster.write(:twitter, @text)

  end

  def send_info_mail
   # email_invite_promos(self)
  end

  def send_sms_to_promoters
    sms_invite_promos(self)
  end
end
