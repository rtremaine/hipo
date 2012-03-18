class AddCommentsToShares < ActiveRecord::Migration
  def change
    add_column :shares, :comment, :text

  end
end
