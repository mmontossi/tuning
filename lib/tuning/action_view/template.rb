module Tuning
  module ActionView
    module Template
      extend ActiveSupport::Concern

      included do
        alias_method_chain :render, :seo
      end

      def render_with_seo(view, locals, buffer=nil, &block)
        output = render_without_seo(view, locals, buffer, &block)
        if Rails::VERSION::MAJOR > 3
          type = type.symbol
        else
          type = mime_type.symbol
        end
        if type == :html and virtual_path
          %w(title description keywords).each do |tag|
            options = (view.instance_variable_get(:@seo_options) || {}).merge(default: '')
            content = I18n.t("#{virtual_path.gsub('/', '.')}.#{tag}", options)
            view.instance_variable_set :"@#{tag}", content
          end
        end
        output
      end

    end
  end
end
