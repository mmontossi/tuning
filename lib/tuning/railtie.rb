module Tuning
  class Railtie < Rails::Railtie

    initializer :tuning do
      ::ActionController::Base.include(
        Tuning::Extensions::ActionController::Base
      )
      ::ActionMailer::Base.include(
        Tuning::Extensions::ActionMailer::Base
      )
      ::ActionView::Base.include(
        Tuning::Extensions::ActionView::Base
      )
      ::ActiveRecord::Base.include(
        Tuning::Extensions::ActiveRecord::Base,
        Tuning::Validations
      )
      ::ActiveModel::Model.include(
        Tuning::Validations
      )
    end

  end
end
