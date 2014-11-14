class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.integer :user_id
      t.integer :user_to
      t.text :text
      t.integer :rate

      t.timestamps
    end
  end
end
