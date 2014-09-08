class AddUseridToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :user_id, :integer
    add_column :vacancies, :country_id, :integer
    add_column :vacancies, :state_id, :integer
    add_column :vacancies, :car, :boolean, :default => 0
    add_column :users, :car, :boolean, :default => 0
    add_column :vacancies, :gender, :string
    rename_column :vacancies, :term, :name
  end
end
