class UserToId < ActiveRecord::Migration
  def change
    rename_column :opinions, :user_to, :user_to_id
  end
end
