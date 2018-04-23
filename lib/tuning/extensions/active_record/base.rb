module Tuning
  module Extensions
    module ActiveRecord
      module Base
        extend ActiveSupport::Concern

        included do
          before_save :nilify_blank_attributes
          alias_method :validate, :valid?
        end

        private

        def nilify_blank_attributes
          attributes.each do |column, value|
            if value.is_a?(String) and value.blank?
              self[column] = nil
            end
          end
        end

        module ClassMethods

          def constraint(attribute, values)
            values.each do |value|
              scope value, -> { where(attribute => value) }
              define_method "#{value}?" do
                send(attribute) == value
              end
            end
            validates_presence_of attribute
            validates_inclusion_of attribute, in: values
          end

          def obfuscates_id
            include Obfuscateable
          end

          def obfuscateable?
            false
          end

        end
      end
    end
  end
end
