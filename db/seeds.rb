# encoding: utf-8

require 'csv'

namespace :csv do

  desc "Import CSV Data"
  task :import_promos => :environment do

    csv_file_path = 'db/promobaza_test.csv'

    CSV.foreach(csv_file_path) do |row|
      User.create!({
        :surname => row[0],
        :name => row[1],
        :birth => row[2],
        :city => row[3],  
        :description => row[4],  
        :phone => row[5],    
        :email => row[6],  
        :med => row[7],  
        :avatar => row[8],  
        :password => "1qaz!QAZ" 
      })
      puts "Row added!"
    end
  end
end