class Article < ActiveRecord::Base
  attr_accessible :name, :text, :user_id

  mount_uploader :picture, PictureUploader
  attr_accessible :picture, :picture_cache, :remove_picture

  validates_presence_of :picture
end
