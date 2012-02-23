class Record < ActiveRecord::Base
  belongs_to :patient
  mount_uploader :record, RecordUploader

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
  {
    "id" => read_attribute(:id),
    "title" => read_attribute(:file_name),
    "description" => "todo", #read_attribute(:description),
    "name" => read_attribute(:record),
    "size" => record.size,
    "url" => record.url,
    #"thumbnail_url" => record.thumb.url,
    #"delete_url" => picture_path(:id => id),
    "delete_type" => "DELETE" 
   }
  end
end
