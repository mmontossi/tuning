module RailsContrib
  module ActionView
    module Base

      def conditional_tag(tag, condition, options=nil, &block)
        condition ? content_tag(tag, options, &block) : capture(&block)
      end

      def active_menu?(path)
        if path == '/'
          request.path == path ? 'active' : ''
        else
          request.path.start_with?(path) ? 'active' : ''
        end
      end

    end
  end
end
