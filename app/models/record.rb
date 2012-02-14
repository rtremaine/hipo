class Record < ActiveRecord::Base
  belongs_to :patient
  mount_uploader :record, RecordUploader
end
