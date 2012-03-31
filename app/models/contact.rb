class Contact < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :company

  validates_presence_of :user#, :company

  def name
    self.user.username
  end

  def self.create_with_user contact_email, user_creating
    contact = Contact.new(:created_by => user_creating.id)
    user = User.find_by_email(contact_email)

    if user
      contact.user_id = user.id
    else
      u = User.new(:email => contact_email, :password => rand(10**10).to_s)
      u.save
      contact.user_id = u.id
    end
    contact
  end
end
