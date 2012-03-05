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
    "url" => record.url,
    "thumbnail_url" => is_image? ? record.thumb.url : "/assets/icon_file_lock_24.png",
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
end
