class Vacancy < ActiveRecord::Base
  attr_accessible :amount, :city_id, :description, :finish_date, :med, :price, :start_date, :term
end
