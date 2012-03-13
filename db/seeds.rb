# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.find_or_initialize_by_email('ryan.trem@gmail.com');
u.password = 'bondaxe'
u.password_confirmation = 'bondaxe'
u.save!
puts u.to_yaml

u = User.find_or_initialize_by_email('thealey@gmail.com');
u.password = 'bondaxe'
u.password_confirmation = 'bondaxe'
if false
  u.save!
  puts u.to_yaml
end

p = Patient.first
if p
  puts p.to_yaml
  p.record_sets = [RecordSet.new({:patient_id => p.id, :name => 'Test 1', :description => 'This is a test'}), 
    RecordSet.new({:patient_id => p.id, :name => 'Test 2', :description => 'This is a test'}),
    RecordSet.new({:patient_id => p.id, :name => 'Test 3', :description => 'This is a test'})]
  p.save!
end
