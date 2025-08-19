module Locatable
  module Grape
    module Presenters
      class Locator < Base

        expose :details, merge: true

        private

          def details
            object.as_json(
              include: {
                location: {
                  methods: [:type]
                },
                locatable: {}
              },
              methods: [:type]
            )
          end

      end
    end
  end
end
