class Reply < ActiveRecord::Base
  attr_accessible :see, :user_id, :user_id_to, :vacancy_id

  belongs_to :user
  belongs_to :vacancy
  belongs_to :user_to, foreign_key: 'user_to_id', class_name: 'User'
end
