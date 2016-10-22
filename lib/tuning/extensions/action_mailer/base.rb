module Tuning
  module Extensions
    module ActionMailer
      module Base
        extend ActiveSupport::Concern

        included do
          after_action :normalize_text_body
        end

        private

        def normalize_text_body
          if mail.content_type.starts_with?('text/plain')
            mail.body = mail.body.to_s.gsub(/\n{3,}/, "\n\n").gsub(/\n +/, "\n").gsub(/^ +/, '')
          end
        end

      end
    end
  end
end
