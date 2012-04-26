class AddStatusToRecordSet < ActiveRecord::Migration
  def change
    add_column :record_sets, :status, :integer
  end
end
