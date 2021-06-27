module Widepay
  module Api
    module Bills
      class Fetch
        PATH = 'recebimentos/cobrancas/consultar'.freeze

        def self.perform(id)
          new(id).perform
        end

        def initialize(id = nil)
          @id = id
        end

        def perform
          Endpoint.new(PATH).post(params)
        end

        private

        def params
          { id: id }
        end

        attr_reader :id
      end
    end
  end
end
