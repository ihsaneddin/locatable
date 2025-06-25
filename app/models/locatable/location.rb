module Locatable
  class Location < Locatable.config.application_record_base_constant

    include Plugins::Models::Concerns::PolymorphicAlternative

    self.table_name = "locatable_locations"

    has_closure_tree hierarchy_table_name: 'locatable_location_hierarchies', dependent: :destroy

    belongs_to :locatable, polymorphic: true, optional: true
    has_many :locators, class_name: "Locatable::Locator", foreign_key: "location_id", dependent: :destroy

    accepts_nested_attributes_for :children, allow_destroy: true
    accepts_nested_attributes_for :locators, allow_destroy: true

    before_validation :resolve_attributes, if: :parent
    after_validation :set_full_address

    def set_full_address
      self.full_address = [unit, building_name, street, city, province, postcode, country].compact.join(', ')
    end

    def resolve_attributes
      %w[building_name, street, city, province, postcode, country latitude longitude].each do |att|
        self.send("#{att}=", parent.send(att)) if send(att).blank?
      end
    end

  end
end