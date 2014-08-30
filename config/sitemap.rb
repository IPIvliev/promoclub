# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://allpromoters.ru"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do

  add '/o-proekte.html', :changefreq => 'monthly', :priority => 0.5
  add '/uslugi.html', :changefreq => 'monthly', :priority => 0.7
  add '/uslugi/poisk-promouterov.html', :changefreq => 'monthly', :priority => 1.0
  add '/uslugi/naiti-rabotu-promouterom.html', :changefreq => 'monthly', :priority => 1.0  
  add '/baza-promouterov.html', :priority => 1.0, :changefreq => 'daily', :priority => 1.0

   User.where("avatar IS NOT NULL AND city_id IS NOT NULL AND name IS NOT NULL AND phone IS NOT NULL AND status = ?", "promo").find_each do |user|
       add user_path(user), :lastmod => user.updated_at, :changefreq => 'monthly', :priority => 0.7
   end

  add '/blog.html', :priority => 0.7, :changefreq => 'weekly', :priority => 0.8

   Article.find_each do |article|
       add article_path(article), :lastmod => article.updated_at, :changefreq => 'never', :priority => 0.6
   end

  add '/kontakti.html', :priority => 0.7, :changefreq => 'yearly', :priority => 0.5 

end
