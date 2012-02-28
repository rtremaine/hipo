class RecordSet < ActiveRecord::Base
  has_many    :records
  belongs_to  :patient
end
