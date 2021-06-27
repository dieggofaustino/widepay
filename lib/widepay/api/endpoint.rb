require 'net/http'
require 'json'

module Widepay
  module Api
    class Endpoint
      def initialize(path)
        @path = path
      end

      def post(params)
        request = Net::HTTP::Post.new(uri.request_uri)
        request.body = params.to_json
        make_request(request)
      end

      private

      def url
        "#{ENV.fetch('WIDEPAY_URL')}/#{path}"
      end

      def uri
        @uri ||= URI.parse(url)
      end

      def make_request(request)
        authenticate_request(request)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        response = http.request(request)
        data = JSON.parse(response.body)

        return data if data['sucesso']
        raise Widepay::Api::Error.new(data)
      end

      def authenticate_request(request)
        request.basic_auth(ENV.fetch('PORTFOLIO_ID'), ENV.fetch('PORTFOLIO_TOKEN'))
        request['Accept'] = 'application/json'
        request['Content-Type'] = 'application/json'
      end

      attr_reader :path
    end
  end
end
