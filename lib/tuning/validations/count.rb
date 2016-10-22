module Tuning
  module Validations
    extend ActiveSupport::Concern

    class CountValidator < ActiveModel::EachValidator
      MESSAGES = { is: :wrong_count, minimum: :too_few, maximum: :too_many }
      CHECKS = { is: :==, minimum: :>=, maximum: :<= }

      def initialize(options)
        if range = (options[:in] || options[:within])
          options[:minimum] = range.min
          options[:maximum] = range.max
        end
        super
      end

      def validate_each(record, attribute, value)
        if value.respond_to?(:size)
          count = value.size
          CHECKS.each do |name, operator|
            if options.has_key?(name)
              other = options[name]
              unless count.send(operator, other)
                record.errors.add attribute, MESSAGES[name], count: other
              end
            end
          end
        else
          record.errors.add attribute, :uncountable
        end
      end

    end
    module ClassMethods

      def validates_count_of(*attr_names)
        validates_with CountValidator, _merge_attributes(attr_names)
      end

    end
  end
end
