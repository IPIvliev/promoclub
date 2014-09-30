class Payment < ActiveRecord::Base
  attr_accessible :amount, :pay, :user_id

  belongs_to :user

  paginates_per 10


  def approve!
    update_attribute(:pay, 1)
  end
end
