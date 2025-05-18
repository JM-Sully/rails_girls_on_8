module ActiveRecord
  module Persistence
    def save!(**options, &block)
      debugger
      create_or_update(**options, &block) || raise(RecordNotSaved.new("Failed to save the record", self))
    end

    module ClassMethods
      def create!(attributes = nil, &block)
        debugger
        if attributes.is_a?(Array)
          attributes.collect { |attr| create!(attr, &block) }
        else
          object = new(attributes, &block)
          object.save!
          object
        end
      end
    end
  end
end

