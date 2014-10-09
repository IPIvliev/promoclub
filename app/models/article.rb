# encoding: utf-8

class Article < ActiveRecord::Base
	include ActionView::Helpers::TextHelper
  attr_accessible :name, :text, :user_id

  mount_uploader :picture, PictureUploader
  attr_accessible :picture, :picture_cache, :remove_picture

  validates_presence_of :picture

  paginates_per 3

  # Отправка в twitter
  after_create :tweet

  private

  def tweet
	client = Twitter::REST::Client.new do |config|
		config.consumer_key        = "NLuHFi35VJ4VS2izyu02Zvjqt"
		config.consumer_secret     = "ceWCb0Tj2xOi2aHmGfjoHFABEqvhSFHiHlVqUsoClZAXmTrkr3"
		config.access_token        = "2818878376-KhQg0tce15KzNKUhGnpTVfu6Kvzg0UFOuqQoonh"
		config.access_token_secret = "yvPwDUzqfN5GtpMIgUJ2jncMD5Ou8RL7Jq37I7sAbEbPY"
	end

	@title = truncate(self.name, :length => 80, :omission => "...")
	@text = "#{@title} http://allpromoters.ru/articles/#{self.id} #промоутеры #реклама"
	client.update(@text)
  end
end
