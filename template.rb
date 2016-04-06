# Template file for new Rails app
def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

run 'cp config/database.yml config/database.yml.example'
append_file '.gitignore', <<-FILE

# ignore local database settings
config/database.yml
FILE

after_bundle do
  say 'initializeing git repository'
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
