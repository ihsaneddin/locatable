module Locatable
  module Grape
    class Locations < Base

      fetch_resource_and_collection! do
        model_klass do
          "Locatable::Location"
        end
      end

      resource "locations" do
        desc "Get list locations"
        get "", authorize: [:read, :locatable_location ],
              model_name: "Locatable::Location",
              action_name: "index" do
          presenter records, locals: presenter_local_options
        end

        desc "Create a location"
        put "", authorize: [:create, :locatable_location ],
              model_name: "Locatable::Location",
              action_name: "create" do
          if record.save
            presenter record, locals: presenter_local_options
          else
            standard_validation_error(details: record.errors)
          end
        end
      end

      resource "location/:id" do
        desc "Get a location"
        get "", authorize: [:read, :locatable_location ],
              model_name: "Locatable::Location",
              action_name: "show" do
          presenter record, locals: presenter_local_options
        end

        desc "Update a location"
        put "", authorize: [:update, :locatable_location ],
              model_name: "Locatable::Location",
              action_name: "update" do
          if record.update permitted_attributes
            presenter record, locals: presenter_local_options
          else
            standard_validation_error(details: record.errors)
          end
        end

        desc "Delete a location"
        put "", authorize: [:destroy, :locatable_location ],
              model_name: "Locatable::Location",
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
