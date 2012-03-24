class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  has_one     :subscription
  belongs_to  :sharing_mode
  belongs_to  :company
  has_many    :contacts

  accepts_nested_attributes_for :company

  attr_accessible :email, :password, :password_confirmation, 
    :remember_me, :stripe_customer_token, :name, 
    :company_attributes, :sharing_mode_id

  def get_token
    self.reset_authentication_token! unless self.authentication_token
    return self.authentication_token
  end

  def username
    if self.name and self.name.size > 0
      return self.name
    else 
      return self.email
    end
  end

  def active_subscription
    Subscription.where(:user_id => self.id, :active => true).first
  end

  def stripe_customer
    Stripe::Customer.retrieve(self.stripe_customer_token) if self.stripe_customer_token
  end

  def stripe_upcoming
    Stripe::Invoice.upcoming(:customer => self.stripe_customer_token)
  end

  def stripe_cancel_subscription
    s = self.stripe_customer.cancel_subscription
    if self.active_subscription
      self.active_subscription.refresh_subscription(s)
    end
  end

  def stripe_delete
    self.stripe_customer.delete
  end

  def stripe_invoices
    invoices = Array.new
    count = 10
    offset = 0
    has_more = true

    while has_more
      is = Stripe::Invoice.all(:customer => self.stripe_customer_token, 
                               :count => count, :offset => offset)
      if is.count == count 
        offset = offset + 10
        invoices << is.data
      else
        invoices << is.data
        has_more = false
      end
    end
    invoices
  end
end

