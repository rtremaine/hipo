class CreateDentists < ActiveRecord::Migration
  def change
    create_table :dentists do |t|
      t.string :first
      t.string :last
      t.string :middle
      t.string :address1
      t.string :address2
      t.integer :user_id
      t.string :email
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
