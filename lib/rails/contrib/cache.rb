module Rails
  module Contrib
    module Cache

      protected

      def increment_cache_namespace(namespace)
        key = "namespaces/#{namespace}"
        value = Rails.cache.read(key)
        Rails.cache.write(key, value.to_i+1)
      end

    end
  end
end
