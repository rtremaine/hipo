class CreateSharingModes < ActiveRecord::Migration
  def change
    create_table :sharing_modes do |t|
      t.string :name
      t.timestamps
    end
  end
end
