class LinkDentistsAndUsersToCompanies < ActiveRecord::Migration
  def change
    add_column :users, :company_id, :integer
    add_column :dentists, :company_id, :integer
  end
end
