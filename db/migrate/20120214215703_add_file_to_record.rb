class AddFileToRecord < ActiveRecord::Migration
  def change
    add_column :records, :record, :string

  end
end
