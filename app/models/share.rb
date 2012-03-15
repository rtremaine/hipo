class Share < ActiveRecord::Base
  belongs_to  :recipient, :class_name => 'Contact'
  belongs_to  :record_set

  validates_presence_of :record_set

  #TODO: improve this it sucks.
  def token
    len = 8
    token = self.id.to_s
    token = token + self.sha
    token = token[0..8]
  end

  #This is just too damn long.
  def sha
    Digest::SHA1.hexdigest self.recipient.user.username + self.created_at.to_s(:long) + 
      User.find(self.sender_id).username
  end
end
