# encoding: utf-8

class RecordUploader < CarrierWave::Uploader::Base
  require 'encdec'
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include CarrierWave::Uploader::Callbacks

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  def store_dir
    "../private/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def secure_file
    Hippo::EncDec.encrypt_file(self.to_s)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  #process :resize_to_fit => [800, 600]

  version :thumb, :if => :image? do
    process :resize_to_fit => [80, 80]
  end
  
  #version :medium, :if => :image? do
  #  process :resize_to_fit => [200, 200]
  #end

  before :store, :foo!
  def foo!(new_file)
    # TODO this is horrible but not yet sure of the correct way to do this. As far as I can tell
    # when it's the original both of these fields have a value. We only want to encrypt the
    # original.
    if (self.url && self.thumb)
      secure_file
    end
  end
 
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end 

protected

  def image?(new_file)
    extension = new_file.extension.to_s
    %w(png jpg jpeg bmp gif tif tiff).include?(extension.downcase)
  end
end
