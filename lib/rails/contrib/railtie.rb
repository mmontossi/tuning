module Rails
  module Contrib
    class Railtie < Rails::Railtie

      initializer 'contrib.cache' do
        ActionController::Caching::Sweeper.send :include, Rails::Contrib::Cache
      end

      initializer 'contrib.error' do
        ActionController::Base.send :include, Rails::Contrib::Error
      end

      initializer 'contrib.flash' do
        ActionController::Base.send :include, Rails::Contrib::Flash
      end

      initializer 'contrib.haml' do
        ActionView::Base.send :include, Rails::Contrib::Haml if defined?(Haml)
      end

      initializer 'contrib.menu' do
        ActionView::Base.send :include, Rails::Contrib::Menu
      end

    end
  end
end
