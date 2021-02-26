# frozen_string_literal: true

require 'net/http'

module SearchEngines # :no-doc:
  # The SearchEngine class represents the parent class from where all other search engines will inherit.
  class SearchEngine
    # Executes the search once the URI and Request has been specified
    # @param uri - The URI where the request will be targeted to
    # @param req - The request object to be executed
    def execute_search(uri, req)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.request(req)
    end
  end
end