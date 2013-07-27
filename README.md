## Rails Framework for Integrating Rails with AngularJS

This is a framework designed for building a full-fledged Rails app together with a versioned, RESTful API for communicating with a complete, scalable, modular AngularJS application.  The code can be found at the [*Rangular Framework*](http://github.com/levbrie/rangular)
by [Lev Brie](http://github.com/levbrie).

Initial Setup 
--------------------------------------------------------------------------------

For more information regarding setup, see {Adam Anderson's blog post}[http://asanderson.org/posts/2013/06/03/bootstrapping-angular-rails-part-1.html] and Michael Hartl's {Ruby on Rails Tutorial}[http://ruby.railstutorial.org/ruby-on-rails-tutorial-book?version=4.0]

1. Get the latest version of RVM

        $ rvm get stable

2. Get the latest version of Ruby, for example:

        $ rvm install ruby-2.0.0-p247

3. Set rvm default to latest version of ruby

        $ rvm --default use 2.0.0-p247

4. Install the latest version of Rails

        $ gem install rails --version 4.0.0

5. Create a default gemset to use with the latest version 

        $ rvm use 2.0.0-p247@gemset --create --default

6. Check Postgres version 

        $ psql --version

7. Install latest Postgres  (skip if you've done this before)

        $ brew install postgresql

8. Create database (skip if already done)

        $ initdb /usr/local/var/postgres

9. Set up an agent to start up the server

        $ mkdir -p ~/Library/LaunchAgents
        $ cp /usr/local/Cellar/postgresql/9.1.3/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents
        $ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

10. Check it's installed in /usr/local/bin/psql (or somewhere similar) 

        $ which psql

11. New Rails App

        $ rails new blog --skip-test-unit --database=postgresql

12. Then go into `/config/database.yml` and make sure it looks like the following (where username matches your username):

        development:
          adapter: postgresql
          encoding: unicode
          database: blog_development
          pool: 5
          username: pguser
          password:

        # ...

        test:
          adapter: postgresql
          encoding: unicode
          database: blog_test
          pool: 5
          username: pguser
          password:


13. Next, create the initial database with the rake db:create command in the console:

        $ bundle exec rake db:create
        $ rails s

You should now be up and running at (http://localhost:3000/)

14. Disable Turbolinks by removing `data-turbolinks-track` from **app/views/layouts/application.html.erb** and `//= require turbolinks` from **app/assets/javascripts/application.js**.  I also like to add in the controller name and action to the class of the body for a quick and dirty way to add styling and js functionality dynamically to pages: `<body class="<%= controller_name %> <%= action_name %>">` (I think I may have gotten this technique from [*Jason Johnson*](http://postpostmodern.com/instructional/a-body-with-class/)).


15. Add the files listed to the Gemfile (see Gemfile)

16. Set up *.ruby-gemset* and **.ruby-version** files with `name_your_gemset` and the latest stable version of ruby (something like `2.0.0-p247`), respectively.

17. Dynamically generate a secret token in *config/initializers/secret_token.rb*. See the [*Ruby on Rails Tutorial*](http://ruby.railstutorial.org/book/ruby-on-rails-tutorial#cha-static_pages) for more info:

        ```ruby
        require 'securerandom'

        def secure_token
          token_file = Rails.root.join('.secret')
          if File.exist?(token_file)
            # Use the existing token.
            File.read(token_file).chomp
          else
            # Generate a new token and store it in token_file.
            token = SecureRandom.hex(64)
            File.write(token_file, token)
            token
          end
        end

        Rangular::Application.config.secret_key_base = secure_token
        ```

    note: make sure to create a .secret file at the root of your rails application and add it to the .gitignore file so that it isn't included in your public repository.

18. Make our initial commit:

    $ git init
    $ git add .
    $ git commit -m "Initial commit"

19. [*Create a new repo on Github (by clicking here)*](https://github.com/new)

    *Note: Make sure not to check "Initialize this repository with a README" since we've already done that*

20. After creating your repository, copy the generated url and add it as the remote:

        $ git remote add origin https://github.com/<username>/rangular.git
        $ git push -u origin master

    *Note: You can find the current application at (https://github.com/levbrie/rangular).*

21. Now deploy to heroku:

        $ heroku create
        $ git push heroku master
        $ heroku run rake db:migrate

Optional Creation of Static Pages 
---------------------------------

*see [*The Rails Tutoral*](http://ruby.railstutorial.org/book/ruby-on-rails-tutorial#sec-first_tests)*
*Note: This static page will serve as the home page, so you will have to create a root route if you choose to skip this section*

1. Checkout a new branch: `$ git checkout -b static-pages`

2. Generate a StaticPages controller with a home action and no test framework:

        $ rails generate controller StaticPages home --no-test-framework

Installing Gems
---------------


1. Install RSpec (should already be in your Gemfile)

        $ rails generate rspec:install

    If you wish to create tests for see "Step04: First Static Page Test" in the wiki

2. Before installing additional gems, make sure that your server is up and working and you can visit the home page (this is unlikely)

    If you can't, first run `$ bundle install` again to install all current gems in the Gemfile.  Now run `$ bundle outdated` to find outdated gems and update those gems, using github urls if necessary. 

3. Install Bootstrap - Follow [*Step05: Installing and Setting Up Bootstrap from the tutorial*](https://github.com/levbrie/rangular/wiki/Step05:-Installing-and-Setting-Up-Bootstrap)

4. Install SimpleForm: Make sure you have `gem 'simple_form'` in your Gemfile (if not, as always, add it and bundle).  Then on the terminal run `$ rails g simple_form:install --bootstrap` (or leave out the optional bootstrap argument if you want simple_form to generate forms without including the default bootstrap theming).  We'll try out the themes and test functionality once we generate our user model.

5. Install Devise: Follow [*Step07: Adding Devise*](https://github.com/levbrie/rangular/wiki/Step07:-Adding-Devise) in the wiki.

6. Install Figaro: Make sure you have `gem 'figaro'` in your Gemfile, then `rails g figaro:install` and simply follow the commented out examples to create private environment variables, i.e. `PUSHER_APP_ID: "2954"`.  This can then be accessed throughout the app using `ENV["PUSHER_APP_ID"]`, and key/value pairs can be safely set using `Pusher.app_id = ENV["PUSHER_APP_ID"]` in the appropriate configuration file.  Additional documentation is available for using a rake task to configure Heroku from the same application.yml file, but this hasn't worked for me so we simply add to Heroku using a single line of key/value pairs.

## Setup Email in Development and Production
--------------------------------------------


1. To set up action mailer for local development and testing using gmail, and to tell devise to actuually perform deliveries, add the following to `config/environments/development.rb`:

    ```ruby
    # devise default mailer options
    config.action_mailer.default_url_options = { :host => 'localhost:3000' }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.default :charset => "utf-8"
    
    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: "yourdomain.com",
      authentication: "plain",
      enable_starttls_auto: true,
      user_name: ENV["GMAIL_USERNAME"],
      password: ENV["GMAIL_PASSWORD"]
    }
    ```
  To test emails using Letter Opener instead, so that the email opens in the browser and is not delivered, include `gem 'letter_opener'` in your Gemfile under `:development` and add `config.action_mailer.delivery_method = :letter_opener` to `config/environments/development.rb`

2. Adding Mandrill: First [*sign up*](http://mandrill.com/).  Then add `gem 'mandrill-api'` to your Gemfile.  

  * The easiest way to add Mandrill in production is through [*Heroku's built-in add-on*](https://devcenter.heroku.com/articles/mandrill) using `$ heroku addons:add mandrill:starter`.

  * Next run `$ heroku config:get MANDRILL_APIKEY` to confirm the environment now has the Mandrill API key set.  

  * Locally replicate the config vars: `$ heroku config -s | grep MANDRILL_APIKEY >> .env` followed by `$ more .env` (which should not output your MANDRILL_APIKEY as a key/value pair)

  * Make sure to exclude the .env file from source control - `echo .env >> .gitignore`. 

  * You'll find your username in the heroku add-ons section for your app, where you can also adjust your settings.  You can add that username to your .env or application.yml file for safe keeping and quick reference if you like but it will already be configured on heroku and you can access it from the command line using `$ heroku config`. 

  * You can now add:

    ```ruby
    # combination of Heroku settings - https://devcenter.heroku.com/articles/mandrill
    # and Mandrill docs 
    config.action_mailer.smtp_settings = {
      :address   => "smtp.mandrillapp.com",
      :port      => '587',                    # ports 587 and 2525 are also supported with STARTTLS
      :enable_starttls_auto => true,          # detects and uses STARTTLS
      :user_name => ENV['MANDRILL_USERNAME'],
      :password  => ENV['MANDRILL_APIKEY'],   # SMTP password is any valid API key
      :authentication => :plain,              # Mandrill supports 'plain' or 'login'
    }
    ```

  to `config/environments/production.rb`

3. If you followed the optional step in the Devise setup to generate Devise's views, you'll find the mailer templates in the `views/users/mailer` directory.  Messages are defined, in `config/locales/devise.en.yml`.  Taken together, you can do a lot of customization just in those two places. 


  

  


