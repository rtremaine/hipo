class CreateSharingModes < ActiveRecord::Migration
  def change
    create_table :sharing_modes do |t|
      t.string :name
      t.timestamps
    end
    SharingMode.new(:name => 'Confirm_Once').save!
    SharingMode.new(:name => 'Confirm_Always').save!
    SharingMode.new(:name => 'Confirm_Never').save!
  end
end
