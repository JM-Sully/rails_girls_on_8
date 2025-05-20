module ActiveRecord
  module Persistence
    def save!(**options, &block)
      debugger
      create_or_update(**options, &block) || raise(RecordNotSaved.new("Failed to save the record", self))
    end

    def create_or_update(**, &block)
      debugger
      _raise_readonly_record_error if readonly?
      return false if destroyed?
      result = new_record? ? _create_record(&block) : _update_record(&block)
      result != false
    end

    def _create_record(attribute_names = self.attribute_names)
      attribute_names = attributes_for_create(attribute_names)

      self.class.with_connection do |connection|
        debugger
        returning_columns = self.class._returning_columns_for_insert(connection)

        returning_values = self.class._insert_record(
          connection,
          attributes_with_values(attribute_names),
          returning_columns
        )

        returning_columns.zip(returning_values).each do |column, value|
          _write_attribute(column, type_for_attribute(column).deserialize(value)) if !_read_attribute(column)
        end if returning_values
      end

      @new_record = false
      @previously_new_record = true
      yield(self) if block_given?
      id
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

      def _insert_record(connection, values, returning)
        debugger
        primary_key = self.primary_key
        primary_key_value = nil

        if prefetch_primary_key? && primary_key
          values[primary_key] ||= begin
            primary_key_value = next_sequence_value
            _default_attributes[primary_key].with_cast_value(primary_key_value)
          end
        end

        im = Arel::InsertManager.new(arel_table)

        if values.empty?
          im.insert(connection.empty_insert_statement_value(primary_key))
        else
          im.insert(values.transform_keys { |name| arel_table[name] })
        end

        connection.insert(
          im, "#{self} Create", primary_key || false, primary_key_value,
          returning: returning
        )
      end
    end
  end
end
