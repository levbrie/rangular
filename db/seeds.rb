# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first) d
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email 	:first_name => ENV['ADMIN_FIRST_NAME'].dup, 
																			:last_name => ENV['ADMIN_LAST_NAME'].dup, 
																			:email => ENV['ADMIN_EMAIL'].dup, 
																			:password => ENV['ADMIN_PASSWORD'].dup, 
																			:password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.first_name
user.add_role :admin
user2 = User.find_or_create_by_email 	:first_name => 'Employee',
																			:last_name => 'TestEmployee', 
																			:email => 'user2@example.com', 
																			:password => 'password555', 
																			:password_confirmation => 'password555'
user2.add_role :employee
customer1 = Customer.find_or_create_by_email 	:company_name => 'Company 1', 
																			:email => 'customer1@example.com', 
																			:password => 'password555', 
																			:password_confirmation => 'password555'
customer2 = Customer.find_or_create_by_email 	:company_name => 'Company 2', 
																			:email => 'customer2@example.com', 
																			:password => 'password555', 
																			:password_confirmation => 'password555'
puts "users: #{user2.first_name}, #{customer1.company_name}, #{customer2.company_name}"

# PRODUCTS
Product.delete_all
product = Product.find_or_create_by_name name: 'Product 1 Test',
															 description: 
															 		%{
															 			This is some text for our first test product
															 			and it is multi-line.
															 		},
															 price: '99.99'
puts "product: " << product.name
