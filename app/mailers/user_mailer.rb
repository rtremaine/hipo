class UserMailer < ActionMailer::Base
  default from: "admin@hippo.flunkyism.com"

  def new_invite(user) 
    @inviter = User.find(user.invited_by_id)
    @user = user
    mail(:to => @user.email, :subject => @inviter.username + ' has invited you to join Hippo')
  end
end
