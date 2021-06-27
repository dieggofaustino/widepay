module Widepay
  module Attributes
    class Bill
      DICTIONARY_NAME = 'bill_attr_dictionary.yml'.freeze

      def self.app_standard
        AppStandard.new(DICTIONARY_NAME)
      end

      def self.api_standard
        ApiStandard.new(DICTIONARY_NAME)
      end
    end
  end
end
