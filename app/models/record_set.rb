class RecordSet < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  has_many    :records
  belongs_to  :patient

  def to_jq_record_set
    {
      'id' => read_attribute(:id),
      'name' => read_attribute(:name),
      'description' => read_attribute(:description),
      'created_at' => read_attribute(:created_at),
      'record_count' => 0,
      'show_url' => record_sets_path.to_s + '/' + self.id.to_s,
      'delete_url' => record_sets_path.to_s + '/' + self.id.to_s,
      'delete_type' => 'DELETE',
    }
  end
end
