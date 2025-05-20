module ActiveModel
  module Validations
    class PresenceValidator < EachValidator
      def validate_each(record, attr_name, value)
        # debugger
        record.errors.add(attr_name, :blank, **options) if value.blank?
      end
    end
  end
end
