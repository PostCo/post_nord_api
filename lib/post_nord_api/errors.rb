# frozen_string_literal: true

module PostNordAPI
  class Error < StandardError; end
  class BadRequestError < Error; end
  class ForbiddenError < Error; end
  class RateLimitError < Error; end
  class ServerError < Error; end
end
