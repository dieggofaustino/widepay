module Widepay
  module Attributes
    class ApiStandard
      def initialize(dictionary_name)
        @dictionary = YAML.load_file("lib/widepay/attributes/#{dictionary_name}")
      end

      def names
        dictionary.map { |d| d['api_name']  }
      end

      def convert(app_attributes)
        case app_attributes.class.to_s
        when 'Hash'  then convert_attributes(app_attributes)
        when 'Array' then convert_collection(app_attributes)
        end
      end

      private

      def convert_collection(collection)
        collection.map do |c|
          convert_attributes(c)
        end
      end

      def convert_attributes(app_attributes)
        {}.tap do |api_attributes|
          app_attributes.each do |name, value|
            attr = dictionary.find { |d| d['app_name'] == name.to_s }
            next unless attr

            api_attributes[attr['api_name']] = cast_type(value, attr['type'])
          end
        end
      end

      def cast_type(value, type)
        return unless value

        case type
        when 'bill_items' then BillItems.api_standard.convert(value)
        else value
        end
      end

      attr_reader :dictionary
    end
  end
end
