class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id
  validates_presence_of :user_id
  
  attr_accessor :stripe_card_token

  def stripe_subscription
    if self.user.stripe_customer_token
      c = Stripe::Customer.retrieve(self.user.stripe_customer_token)
    end

    begin 
      s = c.subscription
      if s
        refresh_subscription(s)
        return s
      end
    rescue
      return nil
    end
  end

  def refresh
    s = self.stripe_subscription
    refresh_subscription(s) if s
  end

  def refresh_subscription(s)
      self.current_period_start = Time.at(s.current_period_start).to_datetime
      self.current_period_end = Time.at(s.current_period_end).to_datetime
      self.trial_start = Time.at(s.trial_start).to_datetime
      self.trial_end = Time.at(s.trial_end).to_datetime
      self.status = s.status
      self.save
  end

  def save_with_payment
    if valid?
      cu = nil

      if self.user.stripe_customer_token
        cu = Stripe::Customer.retrieve(self.user.stripe_customer_token)
      end

      if cu
        s = cu.update_subscription(:plan => plan_id)
        refresh_subscription(s)
      else
        errors.add :base, "Token: " + stripe_card_token

        customer = Stripe::Customer.create(email: self.user.email, 
                                           plan: plan_id, 
                                           card: stripe_card_token)

        self.user.stripe_customer_token = customer.id
        user.save!
        self.save!
        self.refresh
      end
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card in saving payment."
    false
  end
end
