require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MusicApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    RSpotify::authenticate("7f90ecb5287a48cdb71445769c071b6c", "5c98ea2ad11d4101a10e8f3b2c51ee01")
    config.i18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :en
  end
end
