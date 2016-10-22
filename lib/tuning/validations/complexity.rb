module Tuning
  module Validations
    extend ActiveSupport::Concern

    class ComplexityValidator < ActiveModel::EachValidator

      def validate_each(record, attribute, value)
        if value !~ /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[\d])(?=.*[\W\_]).{8,}*\z/
          record.errors.add attribute, :too_easy
        end
      end

    end
    module ClassMethods

      def validates_complexity_of(*attr_names)
        validates_with ComplexityValidator, _merge_attributes(attr_names)
      end

    end
  end
end
