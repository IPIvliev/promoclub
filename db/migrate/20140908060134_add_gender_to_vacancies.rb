class AddGenderToVacancies < ActiveRecord::Migration
  def change
  	add_column :vacancies, :gender, :string
  end
end
