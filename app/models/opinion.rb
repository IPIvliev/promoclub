class Opinion < ActiveRecord::Base
  attr_accessible :rate, :text, :user_id, :user_to_id

  belongs_to :user
  belongs_to :user_to, foreign_key: 'user_to_id', class_name: 'User'

  validates :text, :presence => true, length: { minimum: 5, maximum: 800 }
end
