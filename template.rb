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
after_bundle do
  say 'initializeing git repository'
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
