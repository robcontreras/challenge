# frozen_string_literal: true

module SearchEngines # :no-doc:
  # The GoogleEngine class represents an instance of SearchEngine created to connect specifically to Bing.
  class GoogleEngine < SearchEngine
    include ActiveSupport::Configurable
    config_accessor :api_key, :search_engine_id

    BASE_URL = "https://customsearch.googleapis.com/customsearch/v1"

    # Initialize instance with configuration
    def initialize
      self.api_key =  ENV.fetch('GOOGLE_API_KEY')
      self.search_engine_id = ENV.fetch('GOOGLE_SEARCH_ENGINE_ID')
    end

    # Executes a search with a specific query.
    # @param query The string text to be searched.
    def search(query)
      params = { key: self.api_key, cx: self.search_engine_id, q: query }
      uri = URI(BASE_URL)
      uri.query = URI.encode_www_form(params)
      request = build_request(uri)

      response = self.execute_search(uri, request)
      format_response(response)
    end

    private

    # Builds a request with the necessary headers.
    # @param uri - The URI where the request will be made to
    def build_request(uri)
      Net::HTTP::Get.new(uri)
    end

    # Formats the response from the request.
    # @param response - The response obtained from the executed request
    def format_response(response)
        items = []
        body = JSON.parse(response.body)
      if response.code.to_i == 200
        body['items'].each do |item|
          items << { title: item['title'], link: item['link'], snippet: item['snippet'] }
        end
      else
        items << format_errors(body)
      end
      items
    end

    # Formats the response if there was an error for better understanding of the user
    # @param body - The JSON formatted body of the response
    def format_errors(body)
      {
        error: {
          engine: 'google',
          code: body['error']['code'],
          message: body['error']['message']
        }
      }
    end
  end
end
