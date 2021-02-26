# frozen_string_literal: true

class SearchEngineFactory
  include Singleton

  GOOGLE = 'google'
  BING = 'bing'

  ENGINES_MAP = {
    GOOGLE => SearchEngines::GoogleEngine,
    BING => SearchEngines::BingEngine
  }
  ENGINES = ENGINES_MAP.keys.freeze

  # desc
  def self.from_string(engine_str)
    instance.from_string(engine_str)
  end

  # desc
  def from_string(engine)
    unless ENGINES.include? engine
      raise ArgumentError.new('The engine string provided is not a valid search engine.')
    end

    ENGINES_MAP[engine].new
  end
end