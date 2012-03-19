class Share < ActiveRecord::Base
  belongs_to  :recipient, :class_name => 'Contact'
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :record_set

  validates_presence_of :record_set

  def confirm_status_icon
    return 'icon-lock'
  end

   #TODO: improve this it sucks.
  def token
    len = 8
    token = self.id.to_s
    token = token + self.sha
    token = token[0..5]
  end

  def sha
    Digest::SHA1.hexdigest self.recipient.user.username + self.created_at.to_s(:long) + 
      User.find(self.sender_id).username
  end

  def needs_confirm
    if self.sender.sharing_mode == SharingMode.find_by_name('Confirm_Never')
      return false
    end
    if self.sender.sharing_mode == SharingMode.find_by_name('Confirm_Always')
      return true
    end
    if self.sender.sharing_mode == SharingMode.find_by_name('Confirm_Once')
      if self.recipient.confirmed
        return false
      else
        return true
      end
    end
  end
end
