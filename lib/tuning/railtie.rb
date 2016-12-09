module Tuning
  class Railtie < Rails::Railtie

    initializer 'tuning.extensions' do
      ::ActionController::Base.include(
        Tuning::Extensions::ActionController::Base
      )
      ::ActionMailer::Base.include(
        Tuning::Extensions::ActionMailer::Base
      )
      ::ActionView::Base.include(
        Tuning::Extensions::ActionView::Base
      )
      ::ActionView::Template::Handlers.include(
        Tuning::Extensions::ActionView::Handlers
      )
      ::ActiveRecord::Base.include(
        Tuning::Extensions::ActiveRecord::Base,
        Tuning::Validations
      )
      ::ActiveModel::Model.include(
        Tuning::Validations
      )
    end

    initializer 'tuning.template_handler' do
      ActionView::Template.register_template_handler(
        :ruby,
        ActionView::Template::Handlers::Ruby.new
      )
    end

  end
end
