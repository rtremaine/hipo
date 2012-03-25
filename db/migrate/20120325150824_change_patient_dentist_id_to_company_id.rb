class ChangePatientDentistIdToCompanyId < ActiveRecord::Migration
  def change
    rename_column :patients, :dentist_id, :company_id
  end
end
