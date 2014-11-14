class Reply < ActiveRecord::Base
  attr_accessible :see, :user_id, :user_to_id, :vacancy_id

  belongs_to :user
  belongs_to :vacancy
  belongs_to :user_to, foreign_key: 'user_to_id', class_name: 'User'
end
