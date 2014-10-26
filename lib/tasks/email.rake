# encoding: utf-8

require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :clear_emails => :environment do

    csv_file_path = 'db/activity.csv'

    i = 0

    CSV.foreach(csv_file_path, :col_sep => ";", :row_sep => :auto, :headers => true) do |row|

        if row["email"] != nil && row["status"] != nil
          user = User.where(:email => row["email"])

            if user.update_attribute(:sent, false)

              i = i + 1
              puts "Email denied! Number #{i}"

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