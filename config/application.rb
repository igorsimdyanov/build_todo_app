# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Todo1
  class Application < Rails::Application
    config.load_defaults 6.1

    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :ru
    config.time_zone = 'Moscow'

    config.generators.system_tests = nil
    config.active_job.queue_adapter = :resque

    config.paths.add Rails.root.join('lib').to_s, eager_load: true
    config.paths.add Rails.root.join('app/api/helpers').to_s, eager_load: true

    if Rails.env.production? || ENV['CACHE_TURN_ON']
      config.action_controller.perform_caching = true
      config.action_controller.enable_fragment_cache_logging = true
      config.active_record.cache_versioning = false
      config.cache_store = :redis_store, Rails.application.config_for(:redis).deep_symbolize_keys
    else
      config.action_controller.perform_caching = false
      config.cache_store = :null_store
    end
  end
end
