## Rails Framework for Integrating Rails with AngularJS

This is a framework designed for building a full-fledged Rails app together with a versioned, RESTful API for communicating with a complete, scalable, modular AngularJS application.  The code can be found at the [*Rangular Framework*](http://github.com/levbrie/rangular)
by [Lev Brie](http://github.com/levbrie).

Initial Setup 
-------------

For more information regarding setup, see {Adam Anderson's blog post}[http://asanderson.org/posts/2013/06/03/bootstrapping-angular-rails-part-1.html] and Michael Hartl's {Ruby on Rails Tutorial}[http://ruby.railstutorial.org/ruby-on-rails-tutorial-book?version=4.0]

#### Get the latest version of RVM

    $ rvm get stable

#### Get the latest version of Ruby, for example:

    rvm install ruby-2.0.0-p247

#### Set rvm default to latest version of ruby

    $ rvm --default use 2.0.0-p247

#### Install the latest version of Rails

    $ gem install rails --version 4.0.0

#### Create a default gemset to use with the latest version 

    $ rvm use 2.0.0-p247@gemset --create --default

#### Check Postgres version 

    $ psql --version

#### Install latest Postgres  (skip if you've done this before)

    $ brew install postgresql

#### Create database (skip if already done)

    $ initdb /usr/local/var/postgres

#### Set up an agent to start up the server

    $ mkdir -p ~/Library/LaunchAgents
    $ cp /usr/local/Cellar/postgresql/9.1.3/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents
    $ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

#### Check it's installed in /usr/local/bin/psql (or somewhere similar) 

    $ which psql

#### New Rails App

    $ rails new blog --skip-test-unit --database=postgresql

#### then go into

    /config/database.yml

#### it should look like the following (where username matches your username:)

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


#### Next, create the initial database with the rake db:create command in the console:

    $ bundle exec rake db:create
    $ rails s

#### Should be up and running at: 

    http://localhost:3000/

Disable Turbolinks by removing `data-turbolinks-track` from **app/views/layouts/application.html.erb** and `//= require turbolinks` from **app/assets/javascripts/application.js**


Add the files listed to the Gemfile (see Gemfile)

Set up *.ruby-gemset* and **.ruby-version** files with `name_your_gemset` and the latest stable version of ruby (something like `2.0.0-p247`), respectively.

#### Dynamically generate a secret token in *config/initializers/secret_token.rb*. See the [*Ruby on Rails Tutorial*](http://ruby.railstutorial.org/book/ruby-on-rails-tutorial#cha-static_pages) for more info:

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

#### note: make sure to create a .secret file at the root of your rails application and add it to the .gitignore file so that it isn't included in your public repository.

#### Make our initial commit:

    $ git init
    $ git add .
    $ git commit -m "Initial commit"

[*Create a new repo on Github*](https://github.com/new):

    $ git remote add origin https://github.com/<username>/rangular.git
    $ git push -u origin master

You can find the current application at (https://github.com/levbrie/rangular).
Now deploy to heroku:

    $ heroku create
    $ git push heroku master
    $ heroku run rake db:migrate

#### Install Gems

#### Install RSpec, Figaro 

    $ rails generate rspec:install
    $ rails generate figaro:install  

##### Install Angular

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