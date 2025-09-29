# frozen_string_literal: true

module PostNordAPI
  class Error < StandardError
    attr_reader :response
    def initialize(message, response)
      super(message)
      @response = response
    end
  end
  class BadRequestError < Error; end
  class ForbiddenError < Error; end
  class RateLimitError < Error; end
  class ServerError < Error; end
end
