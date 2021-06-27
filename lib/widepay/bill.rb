require 'json'

module Widepay
  class Bill
    ATTRIBUTES = Attributes::Bill.app_standard.names.freeze

    attr_accessor *ATTRIBUTES

    class << self
      def find(id)
        FindBillService.perform(id)
      end

      def create(attributes)
        CreateBillService.perform(attributes)
      end
    end

    def initialize(attributes = {})
      attributes = JSON.parse(attributes.to_json, { symbolize_names: true })

      ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr}", attributes[attr.to_sym])
      end
    end

    def create
      CreateBillService.perform(attributes)
    end

    def attributes
      {}.tap do |attrs|
        ATTRIBUTES.each do |attr|
          attrs[attr] = instance_variable_get("@#{attr}")
        end
      end
    end
  end
end
