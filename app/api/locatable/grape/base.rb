module Locatable
  module Grape
    class Base < ::Grape::API

      use_plugins_grape(Locatable.config.grape_api)

      format :json

      prefix api_config.prefix if api_config.prefix

      include Locatable::Grape::Helpers
      include Locatable::Grape::Helpers::Authenticate
      include Locatable::Grape::Helpers::Authorize

      resource_context("locatable")

      mount ::Locatable::Grape::Locations
      mount ::Locatable::Grape::Locators


    end
  end
end
