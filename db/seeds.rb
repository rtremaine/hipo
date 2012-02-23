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

