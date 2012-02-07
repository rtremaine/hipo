class AddTitleToDentists < ActiveRecord::Migration
  def change
    add_column  :dentists, :title, :string
  end
end
