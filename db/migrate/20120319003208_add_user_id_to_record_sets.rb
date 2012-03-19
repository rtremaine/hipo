class AddUserIdToRecordSets < ActiveRecord::Migration
  def change
    add_column :record_sets, :user_id, :integer

  end
end
