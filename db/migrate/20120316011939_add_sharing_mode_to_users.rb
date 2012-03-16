class AddSharingModeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sharing_mode_id, :integer, :default => 1
  end
end
