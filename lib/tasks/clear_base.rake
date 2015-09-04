# encoding: utf-8


namespace :clear_base do

  desc "Clean database"

  task :clear_users => :environment do
    puts User.last.name

  end


  task :clear_vacancies => :environment do


  end  

end