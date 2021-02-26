# frozen_string_literal: true

# The SearchEngineFactory class represents a factory made to create new instances of search engines.
class SearchEngineFactory
  include Singleton

  GOOGLE = 'google'
  BING = 'bing'

  ENGINES_MAP = {
    GOOGLE => SearchEngines::GoogleEngine,
    BING => SearchEngines::BingEngine
  }
  ENGINES = ENGINES_MAP.keys.freeze

  # Calls the instance method `from_string` to generate a new SearchEngine child class.
  # @param engine_str - The string name of the engine to be created.
  def self.from_string(engine_str)
    instance.from_string(engine_str)
  end

  # Generates an new instance of a SearchEngine child class.
  # @param engine - The SearchEngine name.
  def from_string(engine)
    unless ENGINES.include? engine
      raise ArgumentError.new('The engine string provided is not a valid search engine.')
    end

    ENGINES_MAP[engine].new
  end
end