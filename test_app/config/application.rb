require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module TestApp
  class Application < Rails::Application
    config.i18n.default_locale = :en
    config.autoload_paths += %w( lib )
  end
end
