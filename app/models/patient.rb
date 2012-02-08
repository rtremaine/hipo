class Patient < ActiveRecord::Base
  belongs_to    :dentist

  def name
    self.last + ', ' + self.first
  end
end
