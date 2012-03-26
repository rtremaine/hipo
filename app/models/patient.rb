class Patient < ActiveRecord::Base
  belongs_to    :company
  has_many      :record_sets, :class_name => RecordSet, :finder_sql => proc{"select record_sets.* from record_sets join users on users.id = record_sets.user_id where users.company_id = #{company_id} and patient_id = #{id}"}
  validates_presence_of   :first, :last

  def name
    self.last + ', ' + self.first
  end
end
