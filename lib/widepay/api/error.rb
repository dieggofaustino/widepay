module Widepay
  module Api
    class Error < ::StandardError
      attr_reader :message, :status

      def initialize(response)
        @message = response['erro']
        @status = response['status']
        super(@message)
      end
    end
  end
end
