module Widepay
  module Api
    class Bill
      class << self
        def fetch(id)
          Bills::Fetch.perform(id)['cobrancas'].first
        end

        def create(attributes)
          Bills::Create.perform(attributes)
        end
      end
    end
  end
end
