Rails.application.config.generators do |g|
  # Disable generators we don't need.
  g.assets                false
  g.stylesheets           false
  g.javascripts           false
  g.helper                false
  g.test_framework        :rspec
  g.scaffold_controller   :bootstrap_scaffold_controller
end
