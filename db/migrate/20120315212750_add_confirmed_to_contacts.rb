class AddConfirmedToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :confirmed, :boolean, :default => false
  end
end
