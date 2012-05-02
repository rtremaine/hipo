class Share < ActiveRecord::Base
  belongs_to  :recipient, :class_name => 'Contact'
  has_one     :recipient_user, :through => :recipient, :source => :user
  belongs_to  :sender, :class_name => 'User'
  belongs_to  :record_set

  validates_presence_of :record_set

  #csv export
  comma do
    record_set 'Patient' do |record_set| record_set.patient.name end 
    record_set :name => 'Record Set Name'
    sender :username => 'Sender'
    recipient 'Recipient' do |recipient| recipient.user.username end
    created_at 'Created' do |created_at| created_at.to_s(:short) end
    received_date 'Received' do |received_date| received_date || '-' end
  end

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
