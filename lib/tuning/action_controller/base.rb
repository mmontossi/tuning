module Tuning
  module ActionController
    module Base
      extend ActiveSupport::Concern

      included do
        rescue_from Exception, with: :error if Rails.env.development?
      end
 
      protected
 
      def error(exception=nil)
        if exception
          logger.error exception.message
          exception.backtrace.each { |line| logger.error line }
        end
        respond_to do |format|
          format.json { head 500 }
          format.any { render file: Rails.root.join('public', '500.html'), status: 500, layout: false }
        end
      end

      def not_found
        respond_to do |format|
          format.json { head 404 }
          format.any { render file: Rails.root.join('public', '404.html'), status: 404, layout: false }
        end
      end  
 
      def unauthorized
        respond_to do |format|
          format.json { head 401 }
          format.any { render file: Rails.root.join('public', '422.html'), status: 401, layout: false }
        end
      end
 
      def forbidden
        respond_to do |format|
          format.json { head 403 }
          format.any { render file: Rails.root.join('public', '422.html'), status: 403, layout: false }
        end
      end

      def unprocessable_entity
        respond_to do |format|
          format.json { head 422 }
          format.any { render file: Rails.root.join('public', '422.html'), status: 422, layout: false }
        end
      end

    end
  end
end
