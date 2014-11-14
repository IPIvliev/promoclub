class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :user_id
      t.date :finish_date

      t.timestamps
    end
  end
end
