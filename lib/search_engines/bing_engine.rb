# frozen_string_literal: true

module SearchEngines # :no-doc:
  # The BingEngine class represents an instance of SearchEngine created to connect specifically to Bing.
  class BingEngine < SearchEngine
    include ActiveSupport::Configurable
    config_accessor :api_key

    BASE_URL = "https://api.bing.microsoft.com/v7.0/search"

    # Initialize instance with configuration
    def initialize
      self.api_key = ENV.fetch('BING_API_KEY')
    end

    # Executes a search with a specific query.
    # @param query The string text to be searched.
    def search(query)
      params = { q: query }
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
      request = Net::HTTP::Get.new(uri)
      request['Ocp-Apim-Subscription-Key'] = self.api_key
      request
    end

    # Formats the response from the request.
    # @param response - The response obtained from the executed request
    def format_response(response)
      body = JSON.parse(response.body)
      items = []
      if response.code.to_i == 200
        body['webPages']['value'].each do |item|
          items << { title: item['name'], link: item['url'], snippet: item['snippet'] }
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
          engine: 'bing',
          code: body['error']['code'],
          message: body['error']['message']
        }
      }
    end
  end
end