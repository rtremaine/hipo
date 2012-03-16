class ShareMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_share share
    @sender = User.find share.sender_id
    @recipient = Contact.find share.recipient_id

    mail(:to => @sender.email, :subject => @sender.name + ' would like to share records with you')
  end
end
