module RailsContrib
  class Railtie < Rails::Railtie

    initializer 'rails_contrib' do
      ::ActionController::Caching::Sweeper.send :include, RailsContrib::ActionController::Caching::Sweeper
      ::ActionController::Base.send :include, RailsContrib::ActionController::Base
      ::ActionView::Base.send :include, RailsContrib::ActionView::Base
    end

  end
end
