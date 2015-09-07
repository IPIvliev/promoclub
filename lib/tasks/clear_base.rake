# encoding: utf-8

namespace :clear_base do

  desc "Clean database"

  task :clear_users => :environment do
    User.where("status = ? AND updated_at < ?", "promo", 6.month.ago).each do |u|
    	u.destroy
    end
  end

  task :clear_vacancies => :environment do
  	Vacancy.where("finish_date < ?", 1.day.ago).each do |v|
  		v.destroy
  	end
  end  

end