source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
gem 'pg'															# Use postgresql as the database for Active Record

# SECURITY, ENCRYPTION, AUTHENTICATION, AUTHORIZATION
gem 'bcrypt-ruby'					 						# adds state-of-the-art encryption hash function
gem 'devise'													# authentication
gem 'simple_form'											# form generation built to work with devise
gem 'cancan'
gem 'rolify'													# for easy role creation

# TEMPLATES
gem 'haml'
gem 'haml-rails'

# ASSET HANDLING
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'				# Use CoffeeScript for .js.coffee assets and views
gem 'less-rails'
gem 'twitter-bootstrap-rails'					# Use the LESS version for better compatibility with Angular app
gem 'uglifier', '>= 1.3.0'						# Use Uglifier as compressor for JavaScript assets

# ERRORS AND ANNOTATIONS
gem 'better_errors'
gem 'binding_of_caller'								# enable REPL and local/instance variable inspection
gem 'meta_request'										# for railspanel chrome extension
gem 'annotate'												# annotation for Rails models, etc.

# TESTING 
gem 'rspec-rails' 										# BDD Testing Framework (behavior-driven development)
gem 'guard'
gem 'guard-livereload'
gem 'guard-rspec'											# auto specs launcher on file modification
gem 'capybara' 												# acceptance test framework (simulates user interaction)
gem 'launchy'													# helper for launching cross-platform apps
gem 'database_cleaner' 								# strategies for cleaning db, ensures clean state for testing
gem 'email_spec'											# collection of RSpec matchers for testing email
gem 'railroady'												# automatic creation of uml diagrams
gem 'rb-fsevent', :require => false		# system-dependent gems for running Guard and getting Growl notifications
gem 'growl'                           # growlnotify bindings for ruby
gem 'spork'														# DRb server for testing frameworks
gem 'guard-spork' 										# auto manage and reload DRb servers on file mod
gem 'faker'														# allows us to make semi-realistic users
gem 'factory_girl_rails'					 		# factories creating objects in db for testing

# JQUERY
gem 'jquery-rails'										# Use jquery as the JavaScript library
gem 'jquery-ui-rails'
gem 'jquery-fileupload-rails'		# for multiple file uploads
gem 'skrollr-rails'	

# UPLOADS, S3, WYSIWYG
gem 'paperclip'
gem 'aws-sdk'													# Amazone AWS for storing files uploaded with paperclip
gem 'cocaine'
gem 'ckeditor'												# more full-featured wysiwyg

# YAML CONFIG FILES SEPARATE FROM APP
gem 'figaro'													# for keeping private stuff private (ENV vars)

# APIS
gem 'jbuilder', '~> 1.2'							# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

# ADDONS
# gem 'paper_trail', github: 'airblade/paper_trail', branch: 'rails4'	# auditing for models

gem 'therubyracer', :require => 'v8' 	# See https://github.com/sstephenson/execjs#readme 
																			# for more supported runtimes
																			# Evaluate JavaScript from within Ruby
																			# Embed your Ruby objects into the JavaScript world
																			# Manipulate JavaScript objects and call JavaScript functions from Ruby
# EMAIL
gem 'mandrill-api'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  gem 'rails_12factor'
end


