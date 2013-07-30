# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first) d
YAML.load(ENV['ROLES']).each do |role|
  Role.create!(:name => role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
admin = User.create!( 	:name=> ENV['ADMIN_NAME'].dup,  
												:email => ENV['ADMIN_EMAIL'].dup, 
												:username => ENV['ADMIN_USERNAME'].dup,
												:password => ENV['ADMIN_PASSWORD'].dup, 
												:password_confirmation => ENV['ADMIN_PASSWORD'].dup,
												:confirmed_at => Time.now)
puts 'admin: ' << admin.name
admin.add_role :admin
developer = User.create!( 	:name=> 'Developer 1',
														:email => 'developer1@example.com', 
														:username => 'developer1',
														:password => 'password55', 
														:password_confirmation => 'password55',
														:confirmed_at => Time.now)
developer.add_role :developer
puts 'developer: ' << developer.name

user = User.create!( 	:name=> 'User 1',
											:email => 'user1@example.com', 
											:username => 'user1',
											:password => 'password55', 
											:password_confirmation => 'password55',
											:confirmed_at => Time.now)
user.add_role :user 
puts 'user: ' << user.name

