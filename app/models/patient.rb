class Patient < ActiveRecord::Base
  belongs_to    :company
  has_many      :record_sets
  validates_presence_of   :first, :last

  def name
    self.last + ', ' + self.first
  end
end
