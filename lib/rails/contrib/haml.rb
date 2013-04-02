module Rails
  module Contrib
    module Haml
      
      def conditional_tag(tag, condition, &block)
        condition ? haml_tag(tag, &block) : yield
      end

    end
  end
end
