module RailsContrib
  module ActionController
    module Base

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

      def redirect_with_flash(options, type, flash)
        args = [options]
        case flash
        when String
          flash = [flash]
        when ActiveRecord::Base
          flash = flash.errors.full_messages
        end
        flash = { :flash => { type => flash } } 
        redirect_to *(args[0].is_a?(Hash) ? args[0].merge(flash) : args.push(flash))
      end

      def flash_errors(source)
        flash.now[:error] = [] unless flash.now[:error].is_a? Array
        case source
        when String
          flash.now[:error] << source
        when Array
          source.each { |error| flash.now[:error] << error }
        when ActiveRecord::Base
          source.errors.full_messages.each { |error| flash.now[:error] << error }
        end
      end

    end
  end
end
