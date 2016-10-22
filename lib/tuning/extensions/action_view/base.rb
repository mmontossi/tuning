module Tuning
  module Extensions
    module ActionView
      module Base
        extend ActiveSupport::Concern

        def active_trail?(path)
          (path == '/' && request.path == path) || request.path.start_with?(path)
        end

        def content_tag_if(condition, name, options={}, &block)
          if condition
            content_tag(name, options, &block)
          else
            capture(&block)
          end
        end

        def extending(layout, &block)
          if block_given?
            old_layout = @view_flow.get(:layout)
            new_layout = (capture(&block) || '')
            old_layout.replace(new_layout)
          end
          render file: "layouts/#{layout}"
        end

      end
    end
  end
end
