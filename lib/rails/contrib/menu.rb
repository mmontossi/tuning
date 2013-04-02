module Rails
  module Contrib
    module Menu

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
