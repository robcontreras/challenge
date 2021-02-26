# frozen_string_literal: true

module SearchEngines
  class BingEngine < SearchEngine
    BASE_URL = "https://api.bing.microsoft.com/v7.0/search"

    # desc
    def search(query)
      params = { q: query }
      uri = URI(BASE_URL)
      uri.query = URI.encode_www_form(params)
      request = build_request(uri)

      response = self.execute_search(uri, request)
      format_response(response)
    end

    private

    # desc
    def build_request(uri)
      request = Net::HTTP::Get.new(uri)
      request['Ocp-Apim-Subscription-Key'] = ENV.fetch('BING_API_KEY')
      request
    end

    # desc
    def format_response(response)
      body = JSON.parse(response.body)
      items = []
      body['webPages']['value'].each do |item|
        items << { title: item['name'], link: item['url'], snippet: item['snippet'] }
      end

      items
    end
  end
end