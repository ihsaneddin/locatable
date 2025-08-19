module Locatable
  class Locator < Locatable.config.application_record_base_constant

    include Plugins::Models::Concerns::PolymorphicAlternative
    include ::Plugins::Models::Concerns::ApiResource

    belongs_to :location, class_name: 'Locatable::Location'
    belongs_to :locatable, polymorphic: true

    grape_api_resource 'locatable', default: true do
      resource_params_attributes do
        [
          :locatable_id, :locatable_type, :location_id, :context, :type
        ]
      end
      presenter "Locatable::Grape::Presenters::Locator"
    end

  end
end