Rails.application.config.generators do |g|
  # Disable generators we don't need.
  g.assets                false
  g.stylesheets           false
  g.javascripts           false
  g.helper                false
  g.test_framework        :rspec,
    fixtures:         true,
    view_specs:       false,
    helper_specs:     false,
    routing_specs:    false,
    controller_specs: false,
    request_specs:    false
  g.factory_girl          dir: 'factories'
  g.scaffold_controller   :bootstrap_scaffold_controller
end
