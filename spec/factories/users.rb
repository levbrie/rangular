include Devise::TestHelpers
FactoryGirl.define do
  factory :user do
  	name 'Test User'
  	email 'test@example.com'
  	password 'password55'
  	password_confirmation 'password55'
  	confirmed_at Time.now 				# use only if implementing Confirmable
  end
end