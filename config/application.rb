require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.precompile += %w(vendor/assets/images/*)
    config.filter_parameters << :password
  	Raven.configure do |config|
  		config.dsn = 'http://328ca02c4d014501bd3e22dd86e4b45f:968b6c3c14994c1993e95371ff1d29f1@sentry.sitd.cz/15'
	 	config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
	end
  end

end
