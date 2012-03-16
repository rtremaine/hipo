class AddEmailedDateToShares < ActiveRecord::Migration
  def change
    add_column :shares, :emailed_date, :datetime

  end
end
