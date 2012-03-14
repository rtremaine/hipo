class AddFaxToDentists < ActiveRecord::Migration
  def change
    add_column :dentists, :fax, :string

  end
end
