# encoding: utf-8

require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :create_promos => :environment do

    csv_file_path = 'db/promobaza-0-100.csv'

    CSV.foreach(csv_file_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |row|
      User.create!({
        :name => row["name"],
        :surname => row["surname"],
        :birth => row["birth"],
        :gender => row["gender"],
        :country_id => row["country_id"],
        :city_id => row["city_id"],  
        :description => row["description"],  
        :phone => row["phone"],    
        :email => row["email"],  
        :med => row["med"],  
        :avatar => open(row["avatar"]),  
        :password => "1qaz$RFV",
        :status => "promo"
      })
      puts "Row added!"
    end
  end
end