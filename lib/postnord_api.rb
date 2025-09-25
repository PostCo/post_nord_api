# frozen_string_literal: true

require_relative 'postnord_api/version'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect('postnord_api' => 'PostnordAPI')

module PostnordAPI
  # Core components
  autoload :Client, 'postnord_api/client'
  autoload :Error, 'postnord_api/errors'
  autoload :BadRequestError, 'postnord_api/errors'
  autoload :ForbiddenError, 'postnord_api/errors'
  autoload :RateLimitError, 'postnord_api/errors'
  autoload :ServerError, 'postnord_api/errors'

  # Resources
  autoload :BaseResource, 'postnord_api/resources/base_resource'
  autoload :ShipmentResource, 'postnord_api/resources/shipment_resource'

  # Objects
  autoload :Base, 'postnord_api/objects/base'
  autoload :Booking, 'postnord_api/objects/booking'
  autoload :Tracking, 'postnord_api/objects/tracking'
end
