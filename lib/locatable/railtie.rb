require 'rails/railtie'

module Locatable
  class Railtie < ::Rails::Railtie

    initializer 'locatable.initialize' do
      ActiveSupport.on_load(:active_record) do
        include ::Locatable::Models::Decorators::Locatable
      end
    end

  end
end