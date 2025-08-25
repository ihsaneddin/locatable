module Locatable
  module Grape
    class Countries < Base

      resource "countries" do
        desc "Get list of countries"
        get "", authorize: [:read, :locatable_location ],
              model_name: "Locatable::Location",
              action_name: "index" do
          present Locatable::Geography.countries
        end
      end

      resource "country/:country_code" do

        resource "states" do
          desc "Get list states"
          get "", authorize: [:read, :locatable_location ],
                model_name: "Locatable::Location",
                action_name: "show" do
            present Locatable::Geography.states(params[:country_code])
          end
        end
        resource "state/:state_code" do
          resource "cities" do
            desc "Get list of cities"
            get "", authorize: [:read, :locatable_location ],
                  model_name: "Locatable::Location",
                  action_name: "show" do
              present Locatable::Geography.cities(params[:country_code], params[:state_code])
            end
          end
        end
      end

    end
  end
end
