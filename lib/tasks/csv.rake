# encoding: utf-8

require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :create_promos => :environment do

    csv_file_path = 'db/job.csv'
    email_good_path = 'db/good.csv'

    i = 0

    CSV.foreach(csv_file_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |row|

      if City.where(:name => row["city"]).first.present?
        city_number = City.where(:name => row["city"]).first.id

        if File.exist?("#{Rails.public_path}/photo/#{row["photo"]}")

          mail = false

          CSV.foreach(email_good_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |good_mail|
            if good_mail["email"].downcase == row["email"].downcase
              mail = true
            end
          end

          if row["name"] != nil && row["surname"] != nil && row["birth"] != nil && row["gender"] != nil && row["country_id"] != nil && row["phone"] != nil && row["email"] != nil && row["med"] != nil && row["photo"] != nil
            user = User.new({
            :name => row["name"],
            :surname => row["surname"],
            :birth => row["birth"],
            :gender => row["gender"],
            :patronymic => row["patronymic"],
            :country_id => row["country_id"],
            :city_id => city_number,  
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

                if mail == false
                  user.update_attribute(:sent, false)
                else
                  InfoMailer.delay.info_email_promo(user)
                end

                i = i + 1

                puts "Row added! Mail #{user.sent}. Number #{i}"

                sleep(60.seconds)
              else
                user.errors.full_messages.each do |msg|
                  puts msg
                end
              end
           # end
            
          else
            puts "Row nil"
          end
        else
          puts "No image"
        end
      else
        puts "No such city #{row["city"]}"
      end
    end
  end


  task :clear_emails => :environment do

    csv_file_path = 'db/activity.csv'

    i = 0

    CSV.foreach(csv_file_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |row|

        if row["email"] != nil
          user = User.where('email = ? AND sent = ?', row["email"], true).first

            if user.present? && user.update_attribute(:sent, false)

              i = i + 1
              puts "Email denied! Number #{i}"

             # sleep(5.seconds)
            else
              puts "Email denied! Number #{row["email"]}"
              #user.errors.full_messages.each do |msg|
              #  puts msg
              #end
            end
         # end
          
        else
          puts "Row nil"
        end

    end
  end







  task :create_agents => :environment do

    csv_file_path = 'db/gis.csv'
    email_good_path = 'db/good-agents.csv'

    i = 0


    CSV.foreach(csv_file_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |row|


          mail = false

          CSV.foreach(email_good_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |good_mail|
            if good_mail["email"] == row["email"].downcase
              mail = true
            end
          end

        if row["name"] != nil && row["city"] != nil && row["phone"] != nil && row["email"] != nil
          if City.where(:name => row["city"]).first.present?
            city_number = City.where(:name => row["city"]).first.id

            user = User.new({
            :name => row["name"],
            :country_id => 3159,
            :city_id => city_number,  
            :site => row["site"],  
            :phone => row["phone"],  
            :avatar => open("#{Rails.public_path}/no_logo.png"),  
            :email => row["email"],  
            :password => "1qaz%TGB",
            :status => "agent"
            })

            if user.save

                if mail == false
                  user.update_attribute(:sent, false)
                else
                  InfoMailer.delay.info_email_agent(user)
		  sleep(40.seconds)
                end

              i = i + 1
              puts "Row added! Mail #{user.sent}. Number #{i}"
	      

            else
              user.errors.full_messages.each do |msg|
                puts msg
              end
            end

           else
            puts "No such city #{row["city"]}"
           end
          
        else
          puts "Row nil"
        end

    end
  end

end