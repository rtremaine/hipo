class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :patient_id
      t.string :file_name

      t.timestamps
    end
  end
end
