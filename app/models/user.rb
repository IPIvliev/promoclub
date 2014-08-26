class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :facebook_url,
  :vk_url, :name, :uid, :gender, :description, :surname, :patronymic, :birth, :phone, :city_id,
  :status, :country_id, :state_id, :med
  # attr_accessible :title, :body

  mount_uploader :avatar, AvatarUploader
  attr_accessible :avatar, :avatar_cache, :remove_avatar

 # validates_presence_of :name, :phone


  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  belongs_to :city
  belongs_to :state
  belongs_to :country

 def self.find_for_facebook_oauth(access_token)
    if user = User.where(:facebook_url => access_token.info.urls.Facebook).first
      user
    else 
      User.create!(
        :uid => access_token.uid,
        :provider => access_token.provider,
        :facebook_url => access_token.info.urls.Facebook, 
        :name => access_token.extra.raw_info.name, 
        :avatar => access_token.info.image, 
        :email => access_token.extra.raw_info.email,
        :password => Devise.friendly_token[0,20]) 
    end
  end

 def self.find_for_vkontakte_oauth(access_token)
    if user = User.where(:vk_url => access_token.info.urls.Vkontakte).first
      user
    else 
      User.create!(
        :uid => access_token.uid,
        :provider => access_token.provider, 
        :vk_url => access_token.info.urls.Vkontakte, 
      :name => access_token.info.name, 
      :avatar => access_token.info.image,
      :email => "#{access_token.uid}@vk.vom", 
      :password => Devise.friendly_token[0,20]) 
    end
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

ransacker :age, :formatter => proc {|v| Date.today - v.to_i.year} do |parent|
  parent.table[:birth]
end

end
