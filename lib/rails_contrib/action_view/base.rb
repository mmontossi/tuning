module RailsContrib
  module ActionView
    module Base

      def self.included(base)
        base.alias_method_chain :submit_tag, :button
      end

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

      def submit_tag_with_button(value='Send', options={})
        button_tag({ :type => 'submit', :name => 'commit' }.update(options)) { content_tag(:span, value) }
      end
      
    end
  end
end
