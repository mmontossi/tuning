module Tuning
  class Railtie < Rails::Railtie

    initializer 'tuning.active_model' do
      ::ActiveModel::Model.include(
        Tuning::Validations
      )
    end

    initializer 'tuning.action_controller' do
      ActiveSupport.on_load :action_controller do
        ::ActionController::Base.include(
          Tuning::Extensions::ActionController::Base
        )
      end
    end

    initializer 'tuning.active_record' do
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::Base.include(
          Tuning::Extensions::ActiveRecord::Base,
          Tuning::Validations
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

    initializer 'tuning.sprockets' do |config|
      assets_path = File.expand_path('../../../app/assets', __FILE__)
      %w(javascripts stylesheets).each do |directory|
        Sprockets.append_path "#{assets_path}/#{directory}"
      end
    end

    initializer 'tuning.i18n' do
      I18n.load_path += Dir[File.expand_path('../locales/*.yml', __FILE__)]
    end

  end
end
