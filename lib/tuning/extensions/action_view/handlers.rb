module Tuning
  module Extensions
    module ActionView
      module Handlers
        extend ActiveSupport::Concern

        class Ruby

          def call(template)
            if template.type.json?
              <<-STRING
                output = begin
                  #{template.source}
                end
                output.to_json
              STRING
            else
              template.source
            end
          end

        end
      end
    end
  end
end
