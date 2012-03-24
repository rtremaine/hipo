class Record < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :patient
  belongs_to :record_set

  mount_uploader :record, RecordUploader

  #convenience method to pass jq_upload the necessary information
  def to_jq_record
  {
    "id" => read_attribute(:id),
    "description" => read_attribute(:description),
    "name" => read_attribute(:record),
    "size" => record.size,
    "url" => '/download_record?id=' + read_attribute(:id).to_s,
    "thumbnail_url" => is_image? ? '/thumbnail?id=' + read_attribute(:id).to_s : "/assets/icon_file_lock_24.png",
    "delete_url" => records_path.to_s + "/" + self.id.to_s,
    "delete_type" => "DELETE" 
   }
  end

  def name
     File.basename(self.record.to_s)
  end

  def is_image?
    %w(.png .jpg .jpeg .bmp .gif .tif .tiff).include?(File.extname(record.to_s).downcase)
  end

  def self.encrypt_file(file)
    #file = self.to_s
    ext_file = file + ".x1"
    File.rename(file, ext_file)

    key = "1234567890123456"
    alg = "bf"
    iv = "6543210987654321"

    blow = OpenSSL::Cipher::Cipher.new alg
    blow.encrypt
    blow.key = key
    blow.iv = iv
    File.open(file,'wb') do |enc|
      File.open(ext_file) do |f|
        loop do
          r = f.read(4096)
          break unless r
          cipher = blow.update(r)
          enc << cipher
        end
      end

      enc << blow.final
    end
    File.unlink(ext_file)
    return file
  end

  def self.decrypt_file(file)
    FileUtils.cp(file, file + '.x1')

    key = "1234567890123456"
    alg = "bf"
    iv = "6543210987654321"

    blow = OpenSSL::Cipher::Cipher.new alg
    blow.decrypt
    blow.key = key
    blow.iv = iv

    File.open(file + '.x2','wb') do |dec|
      File.open(file + '.x1', 'rb') do |f|
        loop do
          r = f.read(4096)
          break unless r
          cipher = blow.update(r)
          dec << cipher
        end
      end

      dec << blow.final
    end
    return file + '.x2'
  end
end
