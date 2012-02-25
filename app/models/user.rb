class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :subscription

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
    :remember_me, :stripe_customer_token

  def stripe_customer
    Stripe::Customer.retrieve(self.stripe_customer_token) if self.stripe_customer_token
  end

  def stripe_upcoming
    Stripe::Invoice.upcoming(:customer => self.stripe_customer_token)
  end

  def stripe_cancel_subscription
    self.stripe_customer.cancel_subscription
    self.subscription.active = false
    self.subscription.save!
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
