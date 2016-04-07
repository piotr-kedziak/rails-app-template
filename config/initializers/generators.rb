Rails.application.config.generators do |g|
  # Disable generators we don't need.
  g.assets                false
  g.stylesheets           false
  g.javascripts           false
  g.helper                false
  g.test_framework        :rspec
  g.factory_girl          dir: 'factories'
  g.scaffold_controller   :bootstrap_scaffold_controller
end
