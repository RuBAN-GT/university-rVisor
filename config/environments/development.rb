Rails.application.configure do
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # assets
  config.assets.debug                = true
  config.assets.compile              = true
  config.assets.digest               = true
  config.assets.raise_runtime_errors = true
  config.assets.compress             = true
  # config.assets.js_compressor        = :uglifier
  config.assets.css_compressor       = :sass

  # translations
  # config.action_view.raise_on_missing_translations = true

  # mail
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options   = { host: 'localhost', port: 3000 }
end
