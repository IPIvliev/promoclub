class Period < ActiveRecord::Base
  attr_accessible :finish_date, :user_id

  validates_presence_of :finish_date

  belongs_to :user


end
