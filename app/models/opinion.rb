class Opinion < ActiveRecord::Base
  attr_accessible :rate, :text, :user_id, :user_to

  belongs_to :user
 # belongs_to :user_to, class_name: "User"
end
