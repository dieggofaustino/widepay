module Widepay
  class FindBillService
    def self.perform(id)
      new(id).perform
    end

    def initialize(id)
      @id = id
    end

    def perform
      Bill.new(app_attributes)
    end

    private

    def app_attributes
      Attributes::Bill.app_standard.convert(api_attributes)
    end

    def api_attributes
      @api_attributes ||= Api::Bill.fetch(id)
    end

    attr_reader :id
  end
end
