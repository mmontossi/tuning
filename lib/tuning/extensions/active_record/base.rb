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
            if value.is_a? String and value.blank?
              self[column] = nil
            end
          end
        end

      end
    end
  end
end
