class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.integer :amount
      t.integer :city_id
      t.string :term
      t.boolean :med
      t.datetime :start_date
      t.datetime :finish_date
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
