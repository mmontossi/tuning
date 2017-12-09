module Tuning
  module Extensions
    module ActionController
      module Base
        extend ActiveSupport::Concern

        included do
          helper_method :root_path, :root_path?, :n, :a
        end

        private

        def root_path
          '/'
        end

        def root_path?
          request.path == root_path
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
