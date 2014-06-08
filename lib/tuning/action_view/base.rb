module Tuning
  module ActionView
    module Base
      extend ActiveSupport::Concern

      included do
        alias_method_chain :submit_tag, :button
      end
 
      def seo_options(options)
        @seo_options = options
      end

      def active_trail?(path)
        (path == '/' && request.path == path) or request.path.start_with?(path)
      end

      def content_tag_if(condition, name, options={}, &block)
        condition ? content_tag(name, options, &block) : capture(&block)
      end

      def submit_tag_with_button(value='Send', options={})
        button_tag({ type: 'submit', name: 'commit' }.update(options)) { content_tag(:span, value) }
      end
 
    end
  end
end
