# encoding: utf-8

class Article < ActiveRecord::Base
	include ActionView::Helpers::TextHelper
  attr_accessible :name, :text, :user_id

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :picture, PictureUploader
  attr_accessible :picture, :picture_cache, :remove_picture

  validates_presence_of :picture

  paginates_per 3

  # Отправка в twitter
   after_create :add_to_social

  private

  def add_to_social

  	@title = truncate(self.name, :length => 80, :omission => "...")
  	@text = "#{@title} http://allpromoters.ru/articles/#{self.id} #промоутеры #реклама"
  	
  	SocialPoster.write(:vk, @text, nil, from_group: 1, owner_id: '-80069050')
  	SocialPoster.write(:twitter, @text)

  end

end
