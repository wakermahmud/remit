source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.2'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Bootstrap
gem 'bootstrap-sass'

# Bootstrap uses autoprefixer, but that has dropped Ruby 1.9 support in recent
# versions
gem 'autoprefixer-rails', '<= 6.1.1'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# For annotating our model files with fields
gem 'annotate'

# For user auth/accounts
gem 'devise'

# For a helpful country field using the ISO3166 country list
gem 'countries'
gem 'country_select'

# For an admin site
gem 'activeadmin', '~> 1.0.0.pre2'

# For the list of "activity" on studies
gem 'public_activity'

# For file uploads
gem "paperclip", "~> 4.3"

# Backported Rails 5 has_secure_token
gem 'has_secure_token'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'debugger'
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'factory_girl_rails', "~> 4.0"
  gem 'codeclimate-test-reporter'
  # Used for nice ActiveRecord/Model matchers in specs
  # Version 3+ don't support Ruby 1.9, hence sticking to 2.x
  gem 'shoulda-matchers', '< 3.0.0'
  # For better headless browser testing
  gem 'poltergeist'
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

