module Tuning
  module ActionController
    module Base
      extend ActiveSupport::Concern

      included do
        rescue_from Exception, with: :error if Rails.env == 'development'
      end

      protected
      
      def error(exception)
        logger.error exception.message
        exception.backtrace.each { |line| logger.error line }
        render file: Rails.root.join('public', '500.html'), status: 500, layout: false
      end

      def not_found
        render file: Rails.root.join('public', '404.html'), status: 404, layout: false
      end  
      
      def forbidden
        render file: Rails.root.join('public', '422.html'), status: 422, layout: false
      end

    end
  end
end
