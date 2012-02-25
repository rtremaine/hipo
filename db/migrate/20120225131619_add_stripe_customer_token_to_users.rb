class AddStripeCustomerTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_token, :string
    remove_column :subscriptions, :stripe_customer_token
  end
end
