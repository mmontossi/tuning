module Tuning
  module Extensions
    module ActionView
      module Handlers
        extend ActiveSupport::Concern

        class Ruby

          def call(template)
            if template.type.json?
              if File.basename(template.identifier).starts_with?('_')
                template.source
              else
                <<~CODE
                  output = begin
                    #{template.source}
                  end
                  if output.is_a?(String)
                    output
                  else
                    output.to_json
                  end
                CODE
              end
            else
              template.source
            end
          end

        end
      end
    end
  end
end
