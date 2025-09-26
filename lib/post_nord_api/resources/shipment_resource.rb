# frozen_string_literal: true

module PostNordAPI
  class ShipmentResource < BaseResource
    def create_return_label(params)
      response = post_request('shipment/v3/returns/edi/labels/zpl', body: parse_params(params))
      Booking.new(response.body)
    end

    def track(tracking_number, locale: 'en')
      response = get_request("shipment/v5/trackandtrace/findByIdentifier.json?id=#{tracking_number}&locale=#{locale}")
      Tracking.new(response.body)
    end
  end
end
