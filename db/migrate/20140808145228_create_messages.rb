class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.boolean :answer
      t.string :name
      t.string :email
      t.string :phone
      t.string :text

      t.timestamps
    end
  end
end
