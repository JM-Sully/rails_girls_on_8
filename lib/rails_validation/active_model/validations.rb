module ActiveModel
  module Validations
    def valid?(context = nil)
      # debugger
      current_context = validation_context
      context_for_validation.context = context
      errors.clear
      run_validations!
    ensure
      context_for_validation.context = current_context
    end

    def run_validations!
      # debugger
      _run_validate_callbacks
      errors.empty?
    end
  end
end
