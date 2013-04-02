module Rails
  module Contrib
    module Flash

      protected

      def redirect_with_flash(path, type, flash, params=nil)
        path = (params.nil? ? path : (params[:back].present? ? params[:back] : path))
        redirect_to path, { :flash => { type => (flash.is_a?(Array) ? flash : [flash]) } }
      end

      def flash_errors(model)
        flash[:error] = [] unless flash[:error].is_a? Array
        model.errors.full_messages.each { |error| flash[:error] << error }
      end

    end  
  end
end
