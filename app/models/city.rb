class City < ActiveRecord::Base
  attr_accessible :name, :state_id

  belongs_to :country
  has_many :users

end
