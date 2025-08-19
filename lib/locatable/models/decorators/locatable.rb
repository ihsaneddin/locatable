module Locatable
  module Models
    module Decorators
      module Locatable

        def self.included base
          base.extend ClassMethods
          base.extend ::Locatable::Configuration::ConfigBuilder
        end

        def self.default_options
          {
            default_context: nil,
          }
        end

        module ClassMethods

          def locatable **opts, &block
            return unless ActiveRecord::Base.connection.table_exists?('locatable_locations')
            default_opts = ::Locatable::Models::Decorators::Locatable.default_options
            plugins_config.setup(self, 'locatable_config', opts, default_opts, &block)


            unless reflect_on_association(:locators)
              has_many :locators, class_name: "Locatable::Locator", as: :locatable
              has_many :addresses, class_name: "Locatable::Location::Address", as: :locatable
              has_many :locations, through: :locators, source: :location, class_name: "Locatable::Location::Place"

              accepts_nested_attributes_for :locators, allow_destroy: true
              accepts_nested_attributes_for :addresses, allow_destroy: true

              assoc_name = "locatable_of_#{self.base_class.name.demodulize.underscore}"
              ::Locatable::Location.define_alternative_polymorphic_parent_association assoc: :locatable, new_assoc: assoc_name, base_class: self.base_class
              ::Locatable::Locator.define_alternative_polymorphic_parent_association assoc: :locatable, new_assoc: assoc_name, base_class: self.base_class
              ::Locatable::Location.has_many assoc_name.pluralize.to_sym, through: :locators, source: :locatable, source_type: self.base_class.name


              scope :in_location!, ->(name) {
                joins(:locations).merge(::Locatable::Location.where(name: name))
              }

              scope :having_address_named!, ->(name) {
                joins(:addresses).merge(::Locatable::Address.where(name: name))
              }

              scope :in_location, ->(name) {
                joins(:locations).where("locatable_locations.name ILIKE ?", "%#{name}%")
              }

              scope :having_address_named, ->(name) {
                joins(:addresses).where("locatable_locations.name ILIKE ?", "%#{name}%")
              }

            end

          end

        end

        module InstanceMethods

          def in_location!(location_name)
            locations.where(name: location_name).exists?
          end

          def in_location?(location_name)
            locations.where("locatable_locations.name ILIKE ?", "%#{name}%").exists?
          end

        end

      end
    end
  end
end