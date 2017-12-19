module Tuning
  module Extensions
    module ActiveRecord
      module Finders
        extend ActiveSupport::Concern

        def find(value)
          if try(:obfuscateable?) && value.is_a?(String) && value !~ /^\d+$/
            find_by! token: value
          else
            super value
          end
        end

        def exists?(value=:none)
          if try(:obfuscateable?) && value.is_a?(String) && value !~ /^\d+$/
            super token: value
          else
            super value
          end
        end

      end
    end
  end
end
