module Tuning
  module Extensions
    module ActiveRecord
      module Obfuscateable
        extend ActiveSupport::Concern

        included do
          before_create :generate_token
        end

        def to_param
          token
        end

        private

        def generate_token
          last_id = self.class.maximum(:id)
          length = [(last_id.to_s.size + 3), 8].max
          token = SecureRandom.base58(length)
          if self.class.exists?(token: token)
            generate_token
          else
            self.token = token
          end
        end

        module ClassMethods

          def obfuscateable?
            true
          end

        end
      end
    end
  end
end
