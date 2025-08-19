module Locatable
  class Location < Locatable.config.application_record_base_constant

    include Plugins::Models::Concerns::PolymorphicAlternative
    include ::Plugins::Models::Concerns::ApiResource

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

    grape_api_resource 'locatable', default: true do
      query_scope do |query|
        query.where(parent_id: nil).order("updated_at desc")
      end
      resource_params_attributes do
        [
          :locatable_id, :locatable_type, :name, :parent_id, :label, :description, :unit, :building_name, :street, :city, :province, :postcode, :country, :latitude, :longitude
        ]
      end
      presenter "Locatable::Grape::Presenters::Location"
    end

  end
end