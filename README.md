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
--------------------------------------------------------------------------------

*see [*The Rails Tutoral*](http://ruby.railstutorial.org/book/ruby-on-rails-tutorial#sec-first_tests)*
*Note: This static page will serve as the home page, so you will have to create a root route if you choose to skip this section*

1. Checkout a new branch: `$ git checkout -b static-pages`

2. Generate a StaticPages controller with a home action and no test framework:

        $ rails generate controller StaticPages home --no-test-framework

Installing Gems
--------------------------------------------------------------------------------


1. Install RSpec (should already be in your Gemfile)

        $ rails generate rspec:install

    If you wish to create tests for see "Step04: First Static Page Test" in the wiki

2. Before installing additional gems, make sure that your server is up and working and you can visit the home page (this is unlikely)

    If you can't, first run `$ bundle install` again to install all current gems in the Gemfile.  Now run `$ bundle outdated` to find outdated gems and update those gems, using github urls if necessary. 

3. Install Bootstrap - Follow Step05: Installing and Setting Up Bootstrap from the tutorial


gem 'devise'                          # authentication
gem 'simple_form'                     # form generation built to work with devise
gem 'cancan'
gem 'rolify'                          # for easy role creation

# TEMPLATES
gem 'haml'
gem 'haml-rails'

# ASSET HANDLING
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'        # Use CoffeeScript for .js.coffee assets and views
gem 'bootstrap-sass'
gem 'uglifier', '>= 1.3.0'            # Use Uglifier as compressor for JavaScript assets

# ERRORS AND ANNOTATIONS
gem 'better_errors'
gem 'binding_of_caller'               # enable REPL and local/instance variable inspection
gem 'meta_request'                    # for railspanel chrome extension
gem 'annotate'                        # annotation for Rails models, etc.

# TESTING 
gem 'rspec-rails'                     # BDD Testing Framework (behavior-driven development)
gem 'guard'
gem 'guard-livereload'
gem 'guard-rspec'                     # auto specs launcher on file modification
gem 'capybara'                        # acceptance test framework (simulates user interaction)
gem 'launchy'                         # helper for launching cross-platform apps
gem 'database_cleaner'                # strategies for cleaning db, ensures clean state for testing
gem 'email_spec'                      # collection of RSpec matchers for testing email
gem 'railroady'                       # automatic creation of uml diagrams
gem 'rb-fsevent', :require => false   # system-dependent gems for running Guard and getting Growl notifications
gem 'growl'                           # growlnotify bindings for ruby
gem 'spork'                           # DRb server for testing frameworks
gem 'guard-spork'                     # auto manage and reload DRb servers on file mod
gem 'faker'                           # allows us to make semi-realistic users
gem 'factory_girl_rails'              # factories creating objects in db for testing

# JQUERY
gem 'jquery-rails'                    # Use jquery as the JavaScript library
gem 'jquery-ui-rails'
gem 'jquery-fileupload-rails'   # for multiple file uploads
gem 'skrollr-rails' 

# UPLOADS, S3, WYSIWYG
gem 'paperclip'
gem 'aws-sdk'                         # Amazone AWS for storing files uploaded with paperclip
gem 'cocaine'
gem 'ckeditor'                        # more full-featured wysiwyg

# YAML CONFIG FILES SEPARATE FROM APP
gem 'figaro'                          # for keeping private stuff private (ENV vars)

# APIS
gem 'jbuilder', '~> 1.2'              # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

# ADDONS
# gem 'paper_trail', github: 'airblade/paper_trail', branch: 'rails4' # auditing for models

gem 'therubyracer', :require => 'v8'  # See https://github.com/sstephenson/execjs#readme 
                                      # for more supported runtimes
                                      # Evaluate JavaScript from within Ruby
                                      # Embed your Ruby objects into the JavaScript world
                                      # Manipulate JavaScript objects and call JavaScript functions from Ruby


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  gem 'rails_12factor'
end


2. Install Figaro (for easy management of sensitive information):

        $ rails generate figaro:install  

1. Install Angular

Download AngularJS Stable, unzip it, place it into +vendor/assets/javascripts+ and add it as a dependency in **app/assets/javascripts/application.js** with +//= require angular+.  Also add requires for bootstrap and underscore and remove the +require_tree+ statement.

The App Itself
--------------

1. Create a Main Controller

    rails g controller Main index
1. In Ruby you can map like this:

        ['a', 'b'].map { |x| x.uppercase }

2. In Rails, you can do a shortcut:

        ['a', 'b'].map(&:uppercase)

Some people seem to like definition lists

<dl>
  <dt>Lower cost</dt>
  <dd>The new version of this product costs significantly less than the previous one!</dd>
  <dt>Easier to use</dt>
  <dd>We've changed the product so that it's much easier to use!</dd>
</dl>

I am a robot
------------

Maybe you want to print `robot` to the console 1000 times. Why not?

    def robot_invasion
      puts("robot " * 1000)
    end



Once you have confirmed things are working, hit Ctrl-C to shutdown your server and return to the command line.



Shut down Rails server

^C
[2013-04-28 09:32:03] INFO  going to shutdown ...
[2013-04-28 09:32:03] INFO  WEBrick::HTTPServer#start done.
Exiting
blog $


Adding AngularJS to the app
Now that we have our Rails app set up, it is time to add the AngularJS framework. Before adding it to our project, though, it is worth disabling Turbolinks since much of the functionality is duplicated within AngularJS. Although it is possible to run Turbolinks in parallel with Angular (see here), in my experience it is more work than it is worth.



Disable Turbolinks
First, go into your app/assets/javascripts/application.js file and remove the //= require turbolinks line from the file. This will stop including turbolinks.js in each of your webpages.

Next, go to app/views/layouts/application.html.erb and remove "data-turbolinks-track" => true from both the stylesheet_link_tag and javascript_include_tag lines. After removing these parameters, the beginning of application.html.erb should look something like this:



 <html>
 <head>
   <title>Application Title</title>
   <%= stylesheet_link_tag    "application", media: "all" %>
   <%= javascript_include_tag "application" %>
   <%= csrf_meta_tags %>
 </head>


Download AngularJS and copy into the project
Download the the latest stable version of AngularJS (at the time of writing 1.0.6) from the AngularJS site, selecting the stable branch and the zip build (which includes both uncompressed and minified assets). Unzip the files and add all of the JS files to your vendor/assets/javascripts directory.



Add AngularJS as a dependency in application.js
Now add a Sprockets require statement in your app/assets/javascripts/application.js file:

// ...

//= require jquery
//= require jquery_ujs
//= require underscore
//= require bootstrap
//= require angular

// ...


Note that we have also removed the require_tree statement, which would have had the effect of loading every javascript file in the project with each page load. This is obviously not an efficient approach with multiple controllers, so we have removed this parameter.