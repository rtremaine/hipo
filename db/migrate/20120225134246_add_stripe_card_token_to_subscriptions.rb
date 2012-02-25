class AddStripeCardTokenToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_card_token, :string
    add_column :subscriptions, :stripe_customer_token, :string
  end
end
