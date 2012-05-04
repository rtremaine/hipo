class ShareMailer < ActionMailer::Base
  default from: "admin@hippo.flunkyism.com"

  def new_share share
    @sender = User.find share.sender_id
    @recipient = Contact.find share.recipient_id
    @share = share
    mail(:to => @recipient.email, :subject => @sender.username + ' would like to share records with you')
  end
end
