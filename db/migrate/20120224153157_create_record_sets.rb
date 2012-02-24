class CreateRecordSets < ActiveRecord::Migration
  def change
    create_table :record_sets do |t|
      t.integer :patient_id
      t.string :name
      t.string :description

      t.timestamps
    end
    rename_column :records, :file_name, :description
    add_column :records, :record_set_id, :integer
  end
end
