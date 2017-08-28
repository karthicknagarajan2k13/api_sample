# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p 'Plan seed start'

['Student', 'Prophent', 'Admin'].each do |r|
  Role.find_or_create_by(name: r)
end

@user = User.find_or_create_by(name: 'admin') do |u|
  u.email = 'admin@yopmail.com'
  u.password = 'Password@123'
  u.password_confirmation = 'Password@123'
  u.role_id = 3
  u.age = 20
  u.gender = 'male'
end

p 'Plan seed end'