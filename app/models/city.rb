class City < ActiveRecord::Base
  attr_accessible :name, :state_id

  belongs_to :country
  belongs_to :state
  has_many :users
  has_many :vacancies

end
