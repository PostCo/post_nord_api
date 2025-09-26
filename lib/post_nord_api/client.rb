# frozen_string_literal: true

require 'faraday'
require 'faraday/net_http'

module PostNordAPI
  class Client
    BASE_URL = 'https://api2.postnord.com/rest'
    SANDBOX_BASE_URL = 'https://atapi2.postnord.com/rest'

    def initialize(api_key:, test_mode: false)
      @api_key = api_key
      @test_mode = test_mode
    end

    def connection
      @connection ||=
        Faraday.new do |conn|
          conn.url_prefix = url_prefix
          conn.request :json
          conn.headers = { 'Content-Type' => 'application/json' }
          conn.params[:apikey] = api_key
          conn.response :json, content_type: 'application/json'
        end
    end

    def shipment
      @shipment ||= ShipmentResource.new(self)
    end

    private

    attr_reader :api_key, :test_mode

    def url_prefix
      test_mode ? SANDBOX_BASE_URL : BASE_URL
    end
  end
end
