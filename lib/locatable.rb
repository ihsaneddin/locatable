require "locatable/version"
require "locatable/engine"
require 'alba'
require 'plugins'
require 'grape'
require 'grape-entity'
require 'closure_tree'
require 'friendly_id'
require "city-state"

module Locatable

  autoload :Configuration, "locatable/configuration"
  autoload :Controllers, "locatable/controllers"
  autoload :Models, "locatable/models"
  autoload :Grape, "locatable/grape"
  autoload :Errors, "locatable/errors"

  mattr_accessor :configuration
  @@configuration = Configuration

  def self.config
    @@configuration
  end

  def self.setup &block
    config.setup &block
  end

end

require "locatable/railtie"