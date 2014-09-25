class User < ActiveRecord::Base
  include UsersHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :facebook_url,
  :vk_url, :name, :uid, :gender, :description, :surname, :patronymic, :birth, :phone, :city_id,
  :status, :country_id, :state_id, :med, :car, :site
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
  has_many :vacancies, :dependent => :destroy

  belongs_to :city
  belongs_to :state
  belongs_to :country

  has_many :opinions, :dependent => :destroy
  has_many :opinions_to_me, foreign_key: "user_to_id", class_name: "Opinion"

  has_many :replies, :dependent => :destroy
  has_many :replies_to_me, foreign_key: "user_to_id", class_name: "Reply"

  has_many :invites, :dependent => :destroy
  has_many :invites_to_me, foreign_key: "user_to_id", class_name: "Invite"

  has_many :sms_invites, :dependent => :destroy
  has_many :sms_invites_to_me, foreign_key: "user_to_id", class_name: "SmsInvite"

    # Отправка письма после создания аккаунта
  after_create :send_greeting_mail

  paginates_per 12

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

  # Додавить и удалить отклик на вакансию
  def reply?(vacancy)
    replies.find_by_vacancy_id(vacancy.id)
  end

  def reply!(vacancy)
    replies.create!(vacancy_id: vacancy.id, user_to_id: vacancy.user.id)
  end

  def unreply!(vacancy)
    replies.find_by_vacancy_id(vacancy.id).destroy
  end


  # Додавить и удалить из избранного
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

# Имя пользователя с рейтингом определённого цвета
  def name_with_rate
    "#{name} #{surname} (#{color_rate(rate)})".html_safe
  end

    private
  def send_greeting_mail
    InfoMailer.info_email(self).deliver
  end

end
