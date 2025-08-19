module Locatable
  class Location::Place < ::Locatable::Location

    validates :name, presence: true, uniqueness: true

  end
end