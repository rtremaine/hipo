class AddFileToRecord < ActiveRecord::Migration
  def change
    add_column :records, :file, :string

  end
end
