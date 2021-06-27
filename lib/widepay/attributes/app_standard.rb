require 'yaml'
require 'date'

module Widepay
  module Attributes
    class AppStandard
      def initialize(dictionary_name)
        @dictionary = YAML.load_file("lib/widepay/attributes/#{dictionary_name}")
      end

      def names
        dictionary.map { |d| d['app_name']  }
      end

      def convert(api_attributes)
        case api_attributes.class.to_s
        when 'Hash'  then convert_attributes(api_attributes)
        when 'Array' then convert_collection(api_attributes)
        end
      end

      private

      def convert_attributes(api_attributes)
        {}.tap do |app_attributes|
          api_attributes.each do |name, value|
            attr = dictionary.find { |d| d['api_name'] == name }
            next unless attr

            app_attributes[attr['app_name']] = cast_type(value, attr['type'])
          end
        end
      end

      def convert_collection(collection)
        collection.map do |c|
          convert_attributes(c)
        end
      end

      def cast_type(value, type)
        return unless value

        case type
        when 'int'   then value.to_i
        when 'float' then value.to_f
        when 'date'  then Date.parse(value)
        else value
        end
      end

      attr_reader :dictionary
    end
  end
end
