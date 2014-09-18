class AddAgeToVacancies < ActiveRecord::Migration
  def change
    add_column :vacancies, :start_age, :integer
    add_column :vacancies, :finish_age, :integer
  end
end
