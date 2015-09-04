set :environment, "production"
set :output, {:error => "log/cron_error.log", :standard => "log/cron.log"}

every 1.day, :at => '5:00 am' do
  rake "-s sitemap:refresh"
end

 every 1.day, :at => '02:56 pm' do
  rake "clear_base:clear_users"
 end

 every 1.day, :at => '04:05 am' do
  rake "clear_base:clear_vacancies"
 end