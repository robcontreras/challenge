# frozen_string_literal: true

module SearchEngines
  class GoogleEngine < SearchEngine
    BASE_URL = "https://customsearch.googleapis.com/customsearch/v1"

    # desc
    def search(query)
      params = { key: ENV.fetch('GOOGLE_API_KEY'), cx: ENV.fetch('GOOGLE_SEARCH_ENGINE_ID'), q: query }
      uri = URI(BASE_URL)
      uri.query = URI.encode_www_form(params)
      request = build_request(uri)

      response = self.execute_search(uri, request)
      format_response(response)
    end

    private

    # desc
    def build_request(uri)
      Net::HTTP::Get.new(uri)
    end

    # desc
    def format_response(response)
      body = JSON.parse(response.body)
      items = []
      body['items'].each do |item|
        items << { title: item['title'], link: item['link'], snippet: item['snippet'] }
      end

      items
    end
  end
end
