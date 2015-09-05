# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  CarrierWave::SanitizedFile.sanitize_regexp = /[^a-zA-Zа-яА-ЯёЁ0-9\.\_\-\+\s\:]/
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [555, 555]
  process :quality => 50 

  version :thumb do
    process :resize_to_fill => [260, 260]
    process :quality => 30 
  end

end
