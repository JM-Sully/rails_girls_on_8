module ActiveRecord
  module Validations
    class PresenceValidator < ActiveModel::Validations::PresenceValidator
      def validate_each(record, attribute, association_or_value)
        # debugger

        if record.class._reflect_on_association(attribute)
          association_or_value = Array.wrap(association_or_value)
                                      .reject(&:marked_for_destruction?)
        end
        super
      end
    end
  end
end
