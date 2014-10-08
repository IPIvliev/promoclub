set :environment, "production"
set :output, {:error => "log/cron_error.log", :standard => "log/cron.log"}

every 1.day, :at => '5:00 am' do
  rake "-s sitemap:refresh"
end