class RecordSet < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  has_many    :records
  belongs_to  :patient
  belongs_to  :user
  validates_presence_of :user_id

  STATUS_VISIBLE = 0
  STATUS_DELETED = 1

  before_create do
    self.status = STATUS_VISIBLE
  end

  def can_see
    return true if self
  end

  def check_permission user
    return true if self.user_id = user.id
  end

  def destroy
    self.status = STATUS_DELETED
    self.save!
  end

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
