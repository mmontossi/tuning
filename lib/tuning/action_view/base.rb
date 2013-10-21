module Tuning
  module ActionView
    module Base
      extend ActiveSupport::Concern

      included do
        alias_method_chain :submit_tag, :button
      end

      def content_tag_if(condition, name, options=nil, &block)
        condition ? content_tag(name, options, &block) : capture(&block)
      end

      def active_menu?(path)
        if path == '/'
          request.path == path ? 'active' : ''
        else
          request.path.start_with?(path) ? 'active' : ''
        end
      end

      def submit_tag_with_button(value='Send', options={})
        button_tag({ type: 'submit', name: 'commit' }.update(options)) { content_tag(:span, value) }
      end
      
    end
  end
end
