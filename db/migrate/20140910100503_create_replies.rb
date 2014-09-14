class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :user_to_id
      t.boolean :see, :default => false
      t.integer :vacancy_id

      t.timestamps
    end
  end
end
