class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id
  validates_presence_of :user_id
  
  attr_accessor :stripe_card_token

  def refresh
    s = self.user.stripe_subscription

    if s
      self.current_period_start = Time.at(s.current_period_start).to_datetime
      self.current_period_end = Time.at(s.current_period_end).to_datetime
      self.trial_start = Time.at(s.trial_start).to_datetime
      self.trial_end = Time.at(s.trial_end).to_datetime
      self.status = s.status
      self.save
    end
  end

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(email: self.user.email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card in saving payment."
    false
  end
end
