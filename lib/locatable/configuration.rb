module Locatable
  module Configuration
    autoload :Api, "locatable/configuration/api"
    autoload :GrapeApi, "locatable/configuration/grape_api"
    autoload :Permissions, "locatable/configuration/permissions"
    autoload :Models, "locatable/configuration/models"
    autoload :ConfigBuilder, "locatable/configuration/config_builder"

    include Plugins::Configuration::Core

    self.api= Locatable::Configuration::Api
    self.grape_api= Locatable::Configuration::GrapeApi
    self.permission_class= Locatable::Configuration::Permissions::Permission

    autoload :Sidekiq, "locatable/configuration/sidekiq"

    mattr_accessor :sidekiq
    @@sidekiq = Sidekiq

    mattr_accessor :enabled_api
    @@enabled_api = :grape

    mattr_accessor :models
    @@models = ::Locatable::Configuration::Models.new

    mattr_accessor :application_record_base
    @@application_record_base = "Locatable::ApplicationRecord"

    def self.application_record_base_constant
      application_record_base.constantize
    end

    mattr_accessor :soft_delete_enabled
    @@soft_delete_enabled = true

  end
end