module Widepay
  module Api
    module Bills
      class Create
        PATH = 'recebimentos/cobrancas/adicionar'.freeze

        def self.perform(attributes)
          Endpoint.new(PATH).post(attributes)
        end
      end
    end
  end
end
