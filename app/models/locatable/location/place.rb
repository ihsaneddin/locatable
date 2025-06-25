module Locatable
  class Place < ::Locatable::Location

    validates :name, presence: true, uniqueness: true

  end
end