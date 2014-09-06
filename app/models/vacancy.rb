class Vacancy < ActiveRecord::Base
  attr_accessible :name, :amount, :country_id, :state_id, :city_id, :description, :finish_date, :med, :price,
  :start_date

  belongs_to :user
  belongs_to :city
  belongs_to :country
end
