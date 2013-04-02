module Rails
  module Contrib
    class Railtie < Rails::Railtie

      ActiveSupport.on_load(:action_controller) do
        include Rails::Contrib::Flash
      end

    end
  end
end
