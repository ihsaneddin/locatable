module Locatable
  class Address < ::Locatable::Location

    class Address < ApplicationRecord

      belongs_to :locatable, polymorphic: true

      with_options :locatable_valid? do
        before_validation do
          self.context ||= self.locatable.locatable_config_default_context
        end
      end
    end

    validate do
      errors.add(:invalid, :locatable) unless valid_locatable?
    end
    validates :locatable, presence: true
    validates :street, :city, :country, presence: true
    validates :name, absence: true

    def valid_locatable?
      locatable.class.include?(::Locatable::Models::Decorators::Locatable::InstanceMethods)
    end

  end
end