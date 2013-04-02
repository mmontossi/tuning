module Rails
  module Contrib
    module Error

      def self.included(base)
        base.class_eval do
          if Rails.env == 'development'
            rescue_from Exception, :with => :error
          end
        end
      end

      protected
      
      def error(exception)
        logger.error exception.message
        exception.backtrace.each { |line| logger.error line }
        render :file => Rails.root.join('public', '500.html'), :status => 500, :layout => false
      end

      def not_found
        render :file => Rails.root.join('public', '404.html'), :status => 404, :layout => false
      end  
      
      def forbidden
        render :file => Rails.root.join('public', '422.html'), :status => 422, :layout => false
      end

    end
  end
end
