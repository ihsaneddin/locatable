module Locatable
  module Grape
    class Locators < Base

      fetch_resource_and_collection! do
        model_klass do
          "Locatable::Locator"
        end
      end

      resource "locators" do
        desc "Get list locators"
        get "", authorize: [:read, :locatable_locator ],
              model_name: "Locatable::Locator",
              action_name: "index" do
          presenter records, locals: presenter_local_options
        end

        desc "Create a locator"
        put "", authorize: [:create, :locatable_locator ],
              model_name: "Locatable::Locator",
              action_name: "create" do
          if record.save
            presenter record, locals: presenter_local_options
          else
            standard_validation_error(details: record.errors)
          end
        end
      end

      resource "locator/:id" do
        desc "Get a locator"
        get "", authorize: [:read, :locatable_locator ],
              model_name: "Locatable::Locator",
              action_name: "show" do
          presenter record, locals: presenter_local_options
        end

        desc "Update a locator"
        put "", authorize: [:update, :locatable_locator ],
              model_name: "Locatable::Locator",
              action_name: "update" do
          if record.update permitted_attributes
            presenter record, locals: presenter_local_options
          else
            standard_validation_error(details: record.errors)
          end
        end

        desc "Delete a locator"
        put "", authorize: [:destroy, :locatable_locator ],
              model_name: "Locatable::Locator",
              action_name: "destroy" do
          if record.destroy
            presenter record, locals: presenter_local_options
          else
            standard_validation_error(details: record.errors)
          end
        end
      end

    end
  end
end
