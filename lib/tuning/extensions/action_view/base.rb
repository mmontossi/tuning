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
            content_tag name, options, &block
          else
            capture &block
          end
        end

        def prepend_classes(value, options)
          if value.is_a?(Array)
            value = value.join(' ')
          end
          if options.has_key?(:class) && options[:class].is_a?(String)
            options[:class].prepend "#{value} "
          else
            options[:class] = value
          end
        end

        def day_select_tag(name, value=nil, options={})
          values = t('date.day_names').each.with_index.to_a
          select_tag name, options_for_select(values, value.to_s), options
        end

        def time_unit_select_tag(name, value=nil, options={})
          values = %w(hours minutes)
          select_tag name, options_for_select(values, value.to_s), options
        end

        def gender_select_tag(name, value=nil, options={})
          values = %w(male female).map do |gender|
            [t("genders.#{gender}"), gender]
          end
          select_tag name, options_for_select(values, value.to_s), options.merge(include_blank: true)
        end

        def seo_tag(name)
          content = (
            content_for(name) || begin
              slugs = params[:controller].split('/')
              key = "#{slugs.join('.')}.#{params[:action]}.#{name}"
              I18n.t(key, default: nil) || begin
                while slugs.any?
                  key = "#{slugs.join('.')}.#{name}"
                  if content = I18n.t(key, default: nil)
                    break content
                  else
                    slugs.pop
                  end
                end
              end
            end
          )
          if content
            if name == :title
              if !root_path? && suffix = content_for(:suffix)
                content << " | #{suffix}"
              end
              content_tag :title, content
            else
              tag :meta, name: name, content: content
            end
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
