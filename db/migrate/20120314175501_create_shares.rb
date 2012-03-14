class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :record_set_id
      t.datetime :received_date

      t.timestamps
    end
  end
end
