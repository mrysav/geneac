require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Geneac
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # optimize autoloader
    # https://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html#upgrading-from-rails-5-2-to-rails-6-0
    config.add_autoload_paths_to_load_path = false


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.active_job.queue_adapter = :resque

    config.generators.assets = false
    config.generators.helper = false
  end
end
