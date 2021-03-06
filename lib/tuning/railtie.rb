module Tuning
  class Railtie < Rails::Railtie

    initializer 'tuning.active_model' do
      ::ActiveModel::Model.include Validations
    end

    initializer 'tuning.action_controller' do
      ActiveSupport.on_load :action_controller do
        ::ActionController::Base.include Extensions::ActionController::Base
      end
    end

    initializer 'tuning.active_record' do
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::Base.include Extensions::ActiveRecord::Base, Validations
      end
    end

    initializer 'tuning.action_view' do
      ActiveSupport.on_load :action_view do
        ::ActionView::Base.include Extensions::ActionView::Base
        ::ActionView::Template::Handlers.include Extensions::ActionView::Handlers
        ::ActionView::Template.register_template_handler(
          :ruby,
          ::ActionView::Template::Handlers::Ruby.new
        )
      end
    end

    initializer 'tuning.sprockets' do |config|
      Sprockets.append_path File.expand_path('../../../app/assets/javascripts', __FILE__)
    end

    initializer 'tuning.i18n' do
      I18n.load_path += Dir[File.expand_path('../locales/*.yml', __FILE__)]
    end

  end
end
