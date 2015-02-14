module Tuning
  module ActionView
    module Base
      extend ActiveSupport::Concern

      def active_trail?(path)
        (path == '/' && request.path == path) or request.path.start_with?(path)
      end

      def content_tag_if(condition, name, options={}, &block)
        condition ? content_tag(name, options, &block) : capture(&block)
      end

    end
  end
end
