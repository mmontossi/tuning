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

      def redirect_with_flash(options, type, flash)
        args = [options]
        if flash.is_a? String
          flash = [flash]
        elsif flash.respond_to? :errors
          flash = flash.errors.full_messages
        end
        flash = { flash: { type => flash } } 
        redirect_to *(args[0].is_a?(Hash) ? args[0].merge(flash) : args.push(flash))
      end

      def flash_errors(source)
        flash.now[:error] = [] unless flash.now[:error].is_a? Array
        if source.is_a? String
          flash.now[:error] << source
        elsif source.is_a? Array
          source.each { |error| flash.now[:error] << error }
        elsif source.respond_to? :errors 
          source.errors.full_messages.each { |error| flash.now[:error] << error }
        end
      end

    end
  end
end
