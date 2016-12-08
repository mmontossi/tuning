module Tuning
  module Extensions
    module ActionController
      module Base
        extend ActiveSupport::Concern

        included do
          define_callbacks :render
        end

        def render(*args)
          run_callbacks(:render) do
            super
          end
        end

        module ClassMethods

          %i(before after around).each do |callback|
            define_method "#{callback}_render" do |*names, &block|
              _insert_callbacks(names, block) do |name, options|
                set_callback :render, callback, name, options
              end
            end

            define_method "prepend_#{callback}_render" do |*names, &block|
              _insert_callbacks(names, block) do |name, options|
                set_callback :render, callback, name, options.merge(prepend: true)
              end
            end

            define_method "skip_#{callback}_render" do |*names|
              _insert_callbacks(names) do |name, options|
                skip_callback :render, callback, name, options
              end
            end

            alias_method :"append_#{callback}_render", :"#{callback}_render"
          end

        end
      end
    end
  end
end
