every 1.day, :at => '5:00 am' do
  rake "-s sitemap:refresh RAILS_ENV=production"
end