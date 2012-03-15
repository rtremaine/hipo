class Share < ActiveRecord::Base
  belongs_to  :recipient, :class_name => 'Contact'
  belongs_to  :record_set

  validates_presence_of :record_set

  def sha
    Digest::SHA1.hexdigest self.recipient.user.username + self.created_at.to_s(:long) + 
      User.find(self.sender_id).username
  end
end
