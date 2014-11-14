class Calculation < ActiveRecord::Base
  attr_accessible :address, :bank, :bik, :inn, :kpp, :ks, :name, :rs, :user_id

  belongs_to :user

  validates :name, :presence => true, length: { minimum: 2, maximum: 255 }
  validates :kpp, :presence => true, :numericality => true
  validates :bik, :presence => true, :numericality => true
  validates :ks, :presence => true, :numericality => true
  validates :rs, :presence => true, :numericality => true
  validates :bank, :presence => true
  validates :address, :presence => true
end
