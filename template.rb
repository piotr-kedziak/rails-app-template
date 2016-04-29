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
  template 'application/_empty.html.erb'
  template 'application/_form_errors.html.erb'
  template 'application/_header.html.erb'
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

say 'creating models concerns...'
inside 'app/models/concerns' do
  template 'nameable.rb'
  template 'timestampable.rb'
end

say 'creating controllers concerns...'
inside 'app/controllers/concerns' do
  template 'devise.rb'
  template 'i18n.rb'
  template 'layout.rb'
end

say 'updating application controller class...'
inject_into_file 'app/controllers/application_controller.rb', after: "ActionController::Base\n" do <<-FILE
  include Concerns::Devise
  include Concerns::I18n
  include Layout
FILE
end

say 'update CSRF in Application Controller settings...'
gsub_file 'app/controllers/application_controller.rb', /protect_from_forgery with: :exception/, 'protect_from_forgery with: :null_session'

# Redis
say 'Installing Redis...'
if File.open('Gemfile') { |f| f.find { |l| l =~ /# gem 'redis'/ } }
  gsub_file 'Gemfile', /# gem 'redis'/, "gem 'redis'"
else
  gem 'redis'
end

# Dalli
say 'Installing Dalli...'
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
  gem 'binding_of_caller'
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

# landing page
say 'Creating landing page...'
generate 'controller landing index'
inside 'app/views/landing' do
  template 'index.html.erb'
end

say 'Creating dashboard...'
generate 'controller home index'
inside 'app/views/home' do
  template 'index.html.erb'
end

# Devise
say 'Intalling Devise...'
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
# user name
inside 'app/controllers' do
  template 'users_controller.rb'
end
generate 'migration add_name_to_users name:index'
inject_into_file 'app/controllers/application_controller.rb', before: "end\n" do <<-FILE

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
      # devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
    end
  # protected
FILE
end
# user model
inject_into_file 'app/models/user.rb', after: "class User < ActiveRecord::Base\n" do <<-FILE
  include Nameable
  include Timestampable
FILE
end
inject_into_file 'app/models/user.rb', before: "end\n" do <<-FILE

  scope :list, -> { oldest_first.by_name }

  validates :terms_accepted, acceptance: { accept: true }
  validates :cookies_accepted, acceptance: { accept: true }
  validates :name, length: { in: 2..150 }

  def name_or_email
    name.present? ? name : email
  end

  def to_s
    name_or_email || id
  end
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
  template 'registrations/_edit_form.html.erb'
  template 'registrations/_new_form.html.erb'
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

say 'Adding mailing settings for environments files...'
inject_into_file 'config/environments/development.rb', after: "config.action_mailer.raise_delivery_errors = false\n" do
  "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }"
end
inject_into_file 'config/environments/test.rb', after: "config.action_mailer.delivery_method = :test\n" do
  "config.action_mailer.default_url_options = { host: 'localhost' }"
end

# database setup
say 'Preparing database...'
run 'rake db:drop'
run 'rake db:create'

# My custom bootstrap scaffold generator
say 'Installing bootstrap scaffold generator...'
inside 'lib/rails/generators/erb/scaffold' do
  copy_file 'scaffold_generator.rb'
end
inside 'lib/rails/generators/rails/bootstrap_scaffold_controller' do
  copy_file 'bootstrap_scaffold_controller_generator.rb'
  copy_file 'templates/controller.rb'
  copy_file 'templates/localization.rb'
end
inside 'lib/rails/generators/rails/scaffold' do
  copy_file 'bootstrap_scaffold_generator.rb'
end
inside 'lib/templates/erb/scaffold' do
  copy_file 'list/_element.html.erb'
  copy_file '_empty.html.erb'
  copy_file '_form.html.erb'
  copy_file '_list.html.erb'
  copy_file 'edit.html.erb'
  copy_file 'index.html.erb'
  copy_file 'new.html.erb'
  copy_file 'show.html.erb'
end

# RSpec
say 'installing RSpec...'
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
say 'Installing Cucumber...'
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
  template 'step_definitions/content_steps.rb'
  template 'step_definitions/form_steps.rb'
  template 'step_definitions/links_steps.rb'
  template 'step_definitions/lists_steps.rb'
  template 'step_definitions/nav_steps.rb'
  template 'step_definitions/navigation_steps.rb'
  template 'step_definitions/users_steps.rb'
  # features
  template 'auth.feature'
  template 'landing.feature'
  template 'nav.feature'
end

# FactoryGirl
say 'Installing FactoryGirl...'
generate 'factory_girl:model User'
inside 'factories' do
  copy_file 'users.rb'
end

# Guard
say 'Installing Guard...'
run 'bundle exec guard init'
run 'bundle binstub guard'

# database setup
say 'Running migrations...'
run 'rake db:migrate'
run 'rake db:migrate RAILS_ENV=test'

after_bundle do
  say 'initializeing git repository'
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
