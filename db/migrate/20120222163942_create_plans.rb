class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
    p = Plan.new
    p.name = 'Basic'
    p.price = 99
    p.save
  end
end
