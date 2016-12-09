module Tuning
  module Extensions
    module ActionView
      module Handlers
        extend ActiveSupport::Concern

        class Ruby

          def call(template)
            <<-STRING
              output = begin
                #{template.source}
              end
              output#{suffix(template.type.symbol)}
            STRING
          end

          private

          def suffix(type)
            if %i(json xml).include?(type)
              ".to_#{type}"
            end
          end

        end
      end
    end
  end
end
