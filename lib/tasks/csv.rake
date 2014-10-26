# encoding: utf-8

require 'csv'
require 'timeout'

namespace :csv do

  desc "Import CSV Data"
  task :create_promos => :environment do

    csv_file_path = 'db/job.csv'

    CSV.foreach(csv_file_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |row|

        if row["name"] != nil && row["surname"] != nil && row["birth"] != nil && row["gender"] != nil && row["country_id"] != nil && row["city_id"] != nil && row["phone"] != nil && row["email"] != nil && row["med"] != nil && row["photo"] != nil
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
          :avatar => open("#{Rails.public_path}/photo/#{row["photo"]}"),  
          :email => row["email"],  
          :med => row["med"],  
          :car => row["car"],
          :password => "1qaz$RFV",
          :status => "promo"
         })

          #Timeout::timeout(10) do # 1 second
            # user.avatar = open("#{Rails.public_path}/photo/#{row["photo"]}")
           # user.remote_avatar_url = row["avatar"]

            if user.save

              row.delete(0)
              puts "Row added!"

             # sleep(5.seconds)
            else
              user.errors.full_messages.each do |msg|
                puts msg
              end
            end
         # end
          
        else
          puts "Row nil"
        end

    end
  end
end