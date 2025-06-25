module Locatable
  module Grape
    class Base < ::Grape::API

      use_plugins_grape(Locatable.config.grape_api)

      format :json
      prefix api_config.prefix if api_config.prefix

      include Locatable::Grape::Helpers::Authenticate
      include Locatable::Grape::Helpers::Authorize

      api_config.load_models.each {|mod| mod.constantize }

      helpers do
        def presenter_local_options opts = params
          opts.merge({
            current_user: current_user,
            current_store: current_store,
            current_device: current_device,
          })
        end
        def event_parameters opts= params
          [
            current_user,
            current_store,
            current_device,
            opts
          ]
        end
      end

      mount ::Locatable::Api::Authenticated


    end
  end
end
