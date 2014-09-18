class Vacancy < ActiveRecord::Base
  attr_accessible :name, :amount, :country_id, :state_id, :city_id, :description, :finish_date, :med, :price,
  :start_date, :gender, :start_age, :finish_age

  belongs_to :user
  belongs_to :city
  belongs_to :country

  has_many :replies, :dependent => :destroy
  has_many :invites, :dependent => :destroy

  paginates_per 7
end
