require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Bestcode2
  class Application < Rails::Application
    config.load_defaults 6.0

    config.generators do |g|
      g.helper false
      g.stylesheets false
      g.template_engine :slim
      g.test_framework :rspec,
                       controller_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end

    config.active_record.default_timezone = :local
    config.time_zone = "Tokyo"

    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.default_locale = :ja

    config.action_view.field_error_proc = Proc.new do |html_tag, _|
      html_tag
    end
  end
end
