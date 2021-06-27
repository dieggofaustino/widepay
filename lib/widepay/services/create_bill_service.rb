module Widepay
  class CreateBillService
    def self.perform(app_attributes)
      new(app_attributes).perform
    end

    def initialize(app_attributes)
      @app_attributes = app_attributes
    end

    def perform
      create_bill
      Bill.new(bill_attributes)
    end

    private

    def api_attributes
      Attributes::Bill.api_standard.convert(app_attributes)
    end

    def create_bill
      @response ||= Api::Bill.create(api_attributes)
    end

    def bill_id
      @response['id']
    end

    def bill_attributes
      app_attributes.merge({ id: bill_id })
    end

    attr_reader :app_attributes
  end
end
