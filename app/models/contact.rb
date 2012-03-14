class Contact < ActiveRecord::Base
  belongs_to  :user

  def name
    self.user.username
  end
end
