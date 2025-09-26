# frozen_string_literal: true

require_relative 'post_nord_api/version'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect('post_nord_api' => 'PostNordAPI')

module PostNordAPI
  # Core components
  autoload :Client, 'post_nord_api/client'
  autoload :Error, 'post_nord_api/errors'
  autoload :BadRequestError, 'post_nord_api/errors'
  autoload :ForbiddenError, 'post_nord_api/errors'
  autoload :RateLimitError, 'post_nord_api/errors'
  autoload :ServerError, 'post_nord_api/errors'

  # Resources
  autoload :BaseResource, 'post_nord_api/resources/base_resource'
  autoload :ShipmentResource, 'post_nord_api/resources/shipment_resource'

  # Objects
  autoload :Base, 'post_nord_api/objects/base'
  autoload :Booking, 'post_nord_api/objects/booking'
  autoload :Tracking, 'post_nord_api/objects/tracking'
end
