# frozen_string_literal: true

require 'net/http'

module SearchEngines
  class SearchEngine
    # desc
    def execute_search(uri, req)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.request(req)
    end
  end
end