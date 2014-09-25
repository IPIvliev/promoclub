class CreateSmsInvites < ActiveRecord::Migration
  def change
    create_table :sms_invites do |t|
      t.integer :user_id
      t.integer :user_to_id
      t.integer :vacancy_id

      t.timestamps
    end
  end
end
