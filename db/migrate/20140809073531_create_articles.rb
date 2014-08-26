class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.text :text
      t.integer :user_id
      t.string :picture

      t.timestamps
    end
  end
end
