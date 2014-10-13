class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.string :user_id
      t.string :name
      t.string :address
      t.integer :inn
      t.integer :kpp
      t.integer :rs
      t.string :bank
      t.string :ks
      t.integer :bik

      t.timestamps
    end
  end
end
