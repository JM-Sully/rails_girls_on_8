module ActiveModel
  class EachValidator < Validator
    def validate(record)
      # debugger
      attributes.each do |attribute|
        value = record.read_attribute_for_validation(attribute)
        next if (value.nil? && options[:allow_nil]) || (value.blank? && options[:allow_blank])
        value = prepare_value_for_validation(value, record, attribute)

        validate_each(record, attribute, value)
      end
    end
  end
end


