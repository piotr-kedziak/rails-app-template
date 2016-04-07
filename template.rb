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

say 'create SCSS files'
inside 'app/assets/stylesheets' do
  template '_colors.scss'
  template '_functions.scss'
  template '_initialize.css.scss'
  template '_variables.scss'
end

# Redis
gsub_file 'Gemfile', /# gem 'redis'/, "gem 'redis'"

# Dalli
gem 'dalli'
gem 'dalli-ui'
inject_into_file 'config/environments/production.rb', before: "  config.action_controller.perform_caching" do <<-FILE

  # Cache
  config.cache_store = :dalli_store, '127.0.0.1', { namespace: '#{app_name.downcase.gsub(' ', '_')}' }
FILE
end

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

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'selenium-webdriver'
  # performance testing https://github.com/rails/rails-perftest
  # gem 'rails-perftest'
  gem 'ruby-prof'
  gem 'mocha'
  # Time freeze or travel for mocking
  # https://github.com/travisjeffery/timecop
  gem 'timecop'
end
FILE

# Devise
gem 'devise', '>= 4.0.0.rc2', github: 'plataformatec/devise'
run 'bundle install'
generate 'devise:install'
inject_into_file 'config/environments/development.rb', after: "config.action_mailer.raise_delivery_errors = false\n" do <<-FILE
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
FILE
end
generate 'devise User'
# terms
generate 'migration add_terms_accepted_to_users terms_accepted:boolean:index'
migration_file = Dir['db/migrate/*_add_terms_accepted_to_users.rb'].first
inject_into_file migration_file, after: ':boolean' do
  ', default: true'
end
# cookies
generate 'migration add_cookies_accepted_to_users cookies_accepted:boolean:index'
migration_file = Dir['db/migrate/*_add_cookies_accepted_to_users.rb'].first
inject_into_file migration_file, after: ':boolean' do
  ', default: true'
end
# user model
inject_into_file 'app/models/user.rb', before: "end\n" do <<-FILE

  validates :terms_accepted, acceptance: true
  validates :cookies_accepted, acceptance: true
FILE
end
# devise routes
inside 'config' do
  template 'routes.rb'
end
# devise views
inside 'app/views/users' do
  template 'confirmations/new.html.erb'
  template 'mailer/confirmation_instructions.html.erb'
  template 'mailer/reset_password_instructions.html.erb'
  template 'mailer/unlock_instructions.html.erb'
  template 'passwords/edit.html.erb'
  template 'passwords/new.html.erb'
  template 'registrations/_destroy.html.erb'
  template 'registrations/_form.html.erb'
  template 'registrations/edit.html.erb'
  template 'registrations/new.html.erb'
  template 'sessions/new.html.erb'
  template 'shared/_links.html.erb'
  template 'shared/_login_with.html.erb'
  template 'unlocks/new.html.erb'
  template '_form.html.erb'
end
# devise initializer
gsub_file('config/initializers/devise.rb',
  /# config.scoped_views = false/,
  'config.scoped_views = true')
gsub_file('config/initializers/devise.rb',
  /config.sign_out_via = :delete/,
  'config.sign_out_via = Rails.env.test? ? [:delete, :get] : :delete')

# RSpec
generate 'rspec:install'
empty_directory_with_keep_file 'spec/support'
empty_directory_with_keep_file 'spec/models'
empty_directory_with_keep_file 'spec/routing'
# RSpec config
inject_into_file 'spec/rails_helper.rb', after: "require 'rspec/rails'\n" do <<-FILE
require 'shoulda/matchers'
require 'factory_girl'
# note: require 'devise' after require 'rspec/rails'
require 'devise'
require 'mocha/mini_test'
FILE
end
inject_into_file 'spec/rails_helper.rb', after: "config.infer_spec_type_from_file_location!\n" do <<-FILE

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: [:controller, :helper]
FILE
end
append_file 'spec/rails_helper.rb' do <<-FILE

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec

    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end

def main_app
  Rails.application.class.routes.url_helpers
end
FILE
end
# copy basic RSpec tests
inside 'spec' do
  copy_file 'controllers/home_controller_spec.rb'
  copy_file 'controllers/landing_controller_spec.rb'
  copy_file 'helpers/btn_helper_spec.rb'
  copy_file 'models/user_spec.rb'
  copy_file 'views/home/index.html.erb_spec.rb'
  copy_file 'views/landing/index.html.erb_spec.rb'
end

# Cucumber
generate 'cucumber:install'
append_file 'features/support/env.rb' do <<-FILE

# Factory Girl
World(FactoryGirl::Syntax::Methods)
FILE
end
# copy basic features / tests / support files
inside 'features' do
  template 'support/debugging.rb'
  # steps
  template 'step_definitions/auth_steps.rb'
  template 'step_definitions/links_steps.rb'
  template 'step_definitions/nav_steps.rb'
  template 'step_definitions/navigation_steps.rb'
  # features
  template 'auth.feature'
  template 'landing.feature'
  template 'nav.feature'
end

after_bundle do
  say 'initializeing git repository'
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
