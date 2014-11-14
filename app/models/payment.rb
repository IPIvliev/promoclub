class Payment < ActiveRecord::Base
  attr_accessible :amount, :pay, :user_id, :status

  belongs_to :user

  paginates_per 10


  def approve!
    update_attribute(:pay, 1)

    @user = User.find(user.id)

    @sum = amount
    @pocket = @user.pocket
    @money = @pocket + @sum

    @user.update_attribute(:pocket, @money)
  end
end
