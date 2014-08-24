# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [848, 364]

  version :thumb do
    process :resize_to_fill => [260, 260]
  end

end
