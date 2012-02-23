class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :subscription

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def stripe_token
    if self.subscription
      return self.subscription.stripe_customer_token
    else
      return nil
    end
  end

  def stripe_customer
    Stripe::Customer.retrieve(self.stripe_token) if self.stripe_token
  end

  def stripe_subscription
    c = Stripe::Customer.retrieve(self.stripe_token) if self.stripe_token
    begin 
      if c.subscription
        return c.subscription
      end
    rescue
      return nil
    end
  end

  def stripe_upcoming
    Stripe::Invoice.upcoming(:customer => self.stripe_token)
  end

  def stripe_cancel_subscription
    self.stripe_customer.cancel_subscription
  end

  def stripe_invoices
    invoices = Array.new
    count = 10
    offset = 0
    has_more = true

    while has_more
      is = Stripe::Invoice.all(:customer => self.stripe_token, :count => count, :offset => offset)
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
