require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Rvisor
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.i18n.fallbacks      = [:en]

    config.active_record.raise_in_transactional_callbacks = true

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    config.autoload_paths += Dir["#{config.root}/lib/"]

    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
  end
end