module Locatable
  module Grape
    module Presenters
      class Location < Base

        expose :details, merge: true

        private

          def details
            object.as_json(
              include: {
                children: {
                  methods: [:type]
                }
              },
              methods: [:type]
            )
          end

      end
    end
  end
end
