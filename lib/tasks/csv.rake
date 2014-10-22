# encoding: utf-8

require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :create_promos => :environment do

    csv_file_path = 'db/job.csv'

    CSV.foreach(csv_file_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |row|
      if row["name"] != nil && row["surname"] != nil && row["patronymic"] != nil && row["birth"] != nil && row["gender"] != nil && row["country_id"] != nil && row["city_id"] != nil && row["phone"] != nil && row["email"] != nil && row["med"] != nil && row["avatar"] != nil
        user = User.new({
        :name => row["name"],
        :surname => row["surname"],
        :birth => row["birth"],
        :gender => row["gender"],
        :patronymic => row["patronymic"],
        :country_id => row["country_id"],
        :city_id => row["city_id"],  
        :description => row["description"],  
        :phone => row["phone"],    
        :email => row["email"],  
        :med => row["med"],  
        :car => row["car"],
        :avatar => open(row["avatar"]),  
        :password => "1qaz$RFV",
        :status => "promo"
       })
        if user.save
          puts "Row added!"
        else
          puts "Row denied"
        end
      else
        puts "Row nil"
      end
    end
  end
end