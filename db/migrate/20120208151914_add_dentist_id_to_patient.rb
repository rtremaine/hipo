class AddDentistIdToPatient < ActiveRecord::Migration
  def change
    add_column  :patients, :dentist_id, :integer
  end
end
