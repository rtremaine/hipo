class AddDescriptionToSharingModes < ActiveRecord::Migration
  def change
    add_column :sharing_modes, :description, :text

  end
end
