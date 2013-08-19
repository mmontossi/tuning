module Tuning
  class Railtie < Rails::Railtie

    initializer 'tuning' do
      ::ActionController::Base.send :include, Tuning::ActionController::Base
      ::ActionView::Base.send :include, Tuning::ActionView::Base
    end

  end
end
