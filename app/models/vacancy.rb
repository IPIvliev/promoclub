# encoding: utf-8

class Vacancy < ActiveRecord::Base
  include VacanciesHelper

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
  after_create :send_info_mail, :add_to_social

  private

  def add_to_social

	@title = truncate(self.name, :length => 80, :omission => "...")
	@text = "#{@title} http://allpromoters.ru/vacancies/#{self.id} #промоутеры #реклама"
	
	SocialPoster.write(:vk, @text, nil, from_group: 1, owner_id: '-80069050')
	SocialPoster.write(:twitter, @text)

  end


	  def send_info_mail
	  	delay.email_invite_promos(self)
	  end
end
