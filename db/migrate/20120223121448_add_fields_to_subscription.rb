class AddFieldsToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :current_period_end, :datetime
    add_column :subscriptions, :current_period_start, :datetime
    add_column :subscriptions, :status, :string
    add_column :subscriptions, :trial_end, :datetime
    add_column :subscriptions, :trial_start, :datetime
  end
end
