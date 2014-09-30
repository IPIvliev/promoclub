class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :pay, :default => 0
      t.decimal :amount, :precision => 9, :scale => 2, :default => 0.0

      t.timestamps
    end
  end
end
