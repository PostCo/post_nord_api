# frozen_string_literal: true

module PostNordAPI
  class BaseResource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    protected

    def get_request(url, params: {}, headers: {})
      handle_response(client.connection.get(url, params, headers))
    end

    def post_request(url, body: {}, headers: {})
      handle_response(client.connection.post(url, body, headers))
    end

    def handle_response(response)
      case response.status
      when 200..299
        response
      else
        handle_error(response)
      end
    end

    def handle_error(response)
      error_message = extract_error_message(response.body)

      case response.status
      when 400
        raise Error, "A bad request or a validation exception has occurred. #{error_message}"
      when 403
        raise ForbiddenError, "Invalid API key. #{error_message}"
      when 429
        raise RateLimitError, "The API rate limit for your application has been exceeded. #{error_message}"
      when 500
        raise ServerError, "An unhandled error with the PostNord API. #{error_message}"
      end
    end

    def parse_params(params)
      # Convert { snake_case_key: value } to { snakeCaseKey: value }
      params.deep_transform_keys { |key| key.to_s.camelize(:lower) }
    end

    private

    def extract_error_message(body)
      case body
      when String
        body
      when Hash
        body['error'] || body['message'] || body.to_s
      else
        'Unknown error'
      end
    end
  end
end
