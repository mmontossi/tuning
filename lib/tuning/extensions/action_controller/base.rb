module Tuning
  module Extensions
    module ActionController
      module Base
        extend ActiveSupport::Concern

        included do
          helper_method :root_path, :root_path?, :last_flash, :n, :a
        end

        private

        def root_path
          '/'
        end

        def root_path?
          request.path == root_path
        end

				def last_flash
					string_or_array = (flash.alert || flash.notice)
					case string_or_array
					when Array
						string_or_array.last
					when String
						string_or_array
					end
				end

        %w(notice alert).each do |type|
          define_method type[0] do |key, options={}|
            t "flash.#{type}.#{key}", options
          end
        end

      end
    end
  end
end
