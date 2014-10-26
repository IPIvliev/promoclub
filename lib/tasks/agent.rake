# encoding: utf-8

require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :create_agents => :environment do

    csv_file_path = 'db/gis.csv'

    i = 0

    CSV.foreach(csv_file_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |row|

        if row["name"] != nil && row["city"] != nil && row["phone"] != nil && row["email"] != nil
          city_number = City.where(:name => row["city"]).id

          user = User.new({
          :name => row["name"],
          :country_id => 3159,
          :city_id => city_number,  
          :site => row["site"],  
          :phone => row["phone"],  
          :avatar => open("#{Rails.public_path}/no_logo.jpg"),  
          :email => row["email"],  
          :password => "1qaz%TGB",
          :status => "agent"
         })

            if user.save

              i = i + 1
              puts "Row added! Number #{i}"

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