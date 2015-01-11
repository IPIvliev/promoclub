set :environment, "production"
set :output, {:error => "log/cron_error.log", :standard => "log/cron.log"}

every 1.day, :at => '5:00 am' do
  rake "-s sitemap:refresh"
end

# every 1.day, :at => '01:56 pm' do
#  rake "csv:create_promos"
# end

# every 1.day, :at => '08:30 am' do
#  rake "csv:create_agents"
# end