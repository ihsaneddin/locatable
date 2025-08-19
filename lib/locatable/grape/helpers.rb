module Locatable
  module Grape
    module Helpers
      autoload :Authenticate, "locatable/grape/helpers/authenticate"
      autoload :Authorize, "locatable/grape/helpers/authorize"

      def self.included(base)
        base.helpers HelperMethods
      end

      module HelperMethods

        def presenter_local_options opts = params
          opts.merge({
            current_user: current_user,
            resource_context: resource_context
          })
        end

        def current_namespaces
          @namespaces ||= []
        end

      end

    end
  end
end