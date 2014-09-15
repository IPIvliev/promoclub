class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :user_to_id
      t.integer :vacancy_id
      t.boolean :see, :default => false

      t.timestamps
    end
  end
end
