module Tuning
  module Validations
    extend ActiveSupport::Concern

    class TimeValidator < ActiveModel::EachValidator
      CHECKS = { before: :<, before_or_equal_to: :<=, after: :>, after_or_equal_to: :>= }

      def validate_each(record, attribute, value)
        if [Date, Time].any? { |klass| value.kind_of?(klass) }
          CHECKS.each do |name, operator|
            if options.has_key?(name)
              other = options[name]
              case other
              when Symbol
                other = record.send(other)
              when Proc
                other = other.call(record)
              end
              unless value.send(operator, other)
                record.errors.add attribute, name, time: I18n.l(other)
              end
            end
          end
        else
          record.errors.add attribute, :not_a_time
        end
      end

    end
    module ClassMethods

      def validates_time_of(*attr_names)
        validates_with TimeValidator, _merge_attributes(attr_names)
      end

    end
  end
end
