# Template file for new Rails app

run 'cp config/database.yml config/database.yml.example'
append_file '.gitignore', <<-FILE

# ignore local database settings
config/database.yml
FILE

after_bundle do
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
