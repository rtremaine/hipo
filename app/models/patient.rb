class Patient < ActiveRecord::Base
  belongs_to    :dentist
  has_many      :record_sets

  def name
    self.last + ', ' + self.first
  end
end
