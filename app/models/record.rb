class Record < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :patient
  belongs_to :record_set

  mount_uploader :record, RecordUploader

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
  {
    "id" => read_attribute(:id),
    "description" => read_attribute(:description),
    "name" => read_attribute(:record),
    "size" => record.size,
    "url" => record.url,
    "thumbnail_url" => record.thumb.url,
    "delete_url" => records_path.to_s + "/" + self.id.to_s,
    "delete_type" => "DELETE" 
   }
  end

  def is_image?
    [".jpg", ".png", ".gif"].include?(File.extname(record.to_s))
  end
end
