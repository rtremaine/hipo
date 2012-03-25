# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sm1 = SharingMode.find_or_initialize_by_name 'Confirm_Once'
sm1.description = 'Confirm once means that the first time you share records with someone, ' +
  'you need to call or email that person to give them a confirmation code. ' + 
  'This ensures they are who you think they are, and that you don\'t have the wrong email address. ' +
  'After this first time you can share any record with this person without needing to exchange any codes ever again.'
sm1.save

sm2 = SharingMode.find_or_initialize_by_name 'Confirm_Always'
sm2.description = 'Confirm always means each contact will always need to input a unique confirmation code before getting records. ' +
  'This the most secure option.'
sm2.save

sm = SharingMode.find_or_initialize_by_name('Confirm_Never')
sm.description = 'Confirm never means no confirmation code is ever needed to download records. ' +
  'This is the least secure option.'
sm.save!

u = User.find_or_initialize_by_email('ryan.trem@gmail.com');
u.password = 'bondaxe'
u.password_confirmation = 'bondaxe'
u.company = Company.find_or_initialize_by_name 'RT Inc.'
u.save!
puts u.to_yaml

u = User.find_or_initialize_by_email('ryan.tremaine@yahoo.com');
u.password = 'bondaxe'
u.password_confirmation = 'bondaxe'
u.company = Company.find_or_initialize_by_name 'Tremaine Ltd.'
u.save!
puts u.to_yaml

u = User.find_or_initialize_by_email('thealey@gmail.com');
u.password = 'bondaxe'
u.password_confirmation = 'bondaxe'
u.company = Company.find_or_initialize_by_name 'TH Inc.'
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
