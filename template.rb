# Template file for new Rails app
def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

run 'cp config/database.yml config/database.yml.example'
append_file '.gitignore', <<-FILE

# ignore local database settings
config/database.yml
FILE

# default I18n files
say 'creating I18n translations files'
empty_directory 'config/locales'
inside 'config/locales' do
  template 'pl.yml.tt'
  template 'en.yml.tt'
  template 'application/form_errors/pl.yml'
  template 'devise/pl.yml'
  template 'devise/en.yml'
  template 'devise_invitable/pl.yml'
  template 'devise_invitable/en.yml'
  template 'flash/pl.yml'
  template 'nav/pl.yml'
  template 'users/pl.yml'
  template 'will_paginate/pl.yml'
end

say 'creating initializers'
inside 'config/initializers' do
  template '_redis.rb'
  template 'generators.rb'
  template 'i18n.rb'
  template 'timezone.rb'
end

say 'creating views helpers'
inside 'app/helpers' do
  template 'btn_helper.rb'
  template 'devise_helper.rb'
  template 'form_helper.rb'
  template 'layout_helper.rb'
  template 'nav_helper.rb'
end

say 'creating views and layouts'
inside 'app/views' do
  template 'application/btn/_back.html.erb'
  template 'application/btn/_login.html.erb'
  template 'application/_form_errors.html.erb'
  template 'flash/_message.html.erb'
  template 'flash/_notifications.html.erb'
  template 'layouts/application.html.erb'
  template 'layouts/base.html.erb'
  template 'layouts/devise.html.erb'
  template 'nav/_element.html.erb'
  template 'nav/_header.html.erb'
  template 'nav/_logout.html.erb'
  template 'nav/_top.html.erb'
end

say 'clear jQuery'
gsub_file 'app/assets/javascripts/application.js', "//= require jquery\n", ''
gsub_file 'Gemfile', "gem 'jquery-rails'", "# gem 'jquery-rails'"

say 'create SCSS files'
inside 'app/assets/stylesheets' do
  template '_colors.scss'
  template '_functions.scss'
  template '_initialize.css.scss'
  template '_variables.scss'
end

# Dalli
gem 'dalli'
gem 'dalli-ui'
gsub_file 'config/environments/production.rb', /.*config.action_controller.perform_caching = true\n/, <<-FILE

  # Cache
  config.cache_store = :dalli_store, '127.0.0.1', { namespace: '#{app_name.downcase.gsub(' ', '_')}' }
  config.action_controller.perform_caching = true
FILE

say 'adding gems for development and test environments'
gsub_file 'Gemfile', /group :development, :test do\n.*\nend/m, <<-FILE
group :development, :test do
  # debugger
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'bullet'
  # testing
  gem 'rspec-rails'
  gem 'cucumber-rails', require: false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'rails-controller-testing'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Guard::RSpec automatically run your specs (much like autotest) https://rubygems.org/gems/guard-rspec
  # https://github.com/guard/guard-rspec
  gem 'guard-rspec', require: false
  # Guard::Bundler automatically install/update your gem bundle when needed
  gem 'guard-bundler', require: false
  # Guard::Cucumber allows you to automatically run Cucumber features when files are modified.
  gem 'guard-cucumber'
  gem 'webrat'
  # The easiest way to get a working readline implementation is to install rb-readline, a pure Ruby readline implementation.
  gem 'rb-readline'
  # Guard notifications in OSX Notification center
  gem 'terminal-notifier-guard'
  gem 'terminal-notifier'
  # https://github.com/ruckus/active-record-query-trace
  gem 'active_record_query_trace'
  # https://github.com/josevalim/rails-footnotes
  # gem 'rails-footnotes'
  # Rails Panel for Chrome
  # gem 'meta_request'
end
FILE

after_bundle do
  say 'initializeing git repository'
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
