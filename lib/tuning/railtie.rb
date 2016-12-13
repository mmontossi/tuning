module Tuning
  class Railtie < Rails::Railtie

    initializer 'tuning.active_model' do
      ::ActiveModel::Model.include(
        Tuning::Validations
      )
    end

    initializer 'tuning.active_record' do
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::Base.include(
          Tuning::Extensions::ActiveRecord::Base,
          Tuning::Validations
        )
      end
    end

    initializer 'tuning.action_controller' do
      ActiveSupport.on_load :action_controller do
        ::ActionController::Base.include(
          Tuning::Extensions::ActionController::Base
        )
      end
    end

    initializer 'tuning.action_mailer' do
      ActiveSupport.on_load :action_mailer do
        ::ActionMailer::Base.include(
          Tuning::Extensions::ActionMailer::Base
        )
      end
    end

    initializer 'tuning.action_view' do
      ActiveSupport.on_load :action_view do
        ::ActionView::Base.include(
          Tuning::Extensions::ActionView::Base
        )
        ::ActionView::Template::Handlers.include(
          Tuning::Extensions::ActionView::Handlers
        )
        ::ActionView::Template.register_template_handler(
          :ruby,
          ::ActionView::Template::Handlers::Ruby.new
        )
      end
    end

  end
end
