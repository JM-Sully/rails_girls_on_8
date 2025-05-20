module ActiveRecord
  module Validations
    def save!(**options)
      debugger
      perform_validations(options) ? super : raise_validation_error
    end

    def perform_validations(options = {})
      # debugger
      options[:validate] == false || valid?(options[:context])
    end

    def valid?(context = nil)
      # debugger
      context ||= default_validation_context
      output = super(context)
      errors.empty? && output
    end
  end
end
