module Locatable
  class Locator < Locatable.config.application_record_base_constant

    include Plugins::Models::Concerns::PolymorphicAlternative

    belongs_to :location, class_name: 'Locatable::Location'
    belongs_to :locatable, polymorphic: true

  end
end