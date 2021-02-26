# frozen_string_literal: true

class SearchProcessor
  # desc
  def initialize(engine, query)
    @engine = engine
    @query = query

    @errors = []
    check_for_errors
  end

  def execute

    return { errors: @errors.join('\n') }.to_json if @errors.length > 0

    case @engine
    when 'both'
      google_results = SearchEngineFactory.from_string(SearchEngineFactory::GOOGLE).search(@query)
      bing_results = SearchEngineFactory.from_string(SearchEngineFactory::BING).search(@query)
      results = google_results.concat(bing_results)
    else
      begin
        search_engine = SearchEngineFactory.from_string(@engine)
        results = search_engine.search(@query)
      rescue => e
        return { errors: e }.to_json
      end
    end

    results.to_json
  end

  private

  # desc
  def check_for_errors
    text_validation
    engine_validation
    @errors.compact!
  end

  # desc
  def text_validation
    err = @query.present? ? nil : 'Please provide a text to search for.'
    @errors << err
  end

  # desc
  def engine_validation
    err = @engine.present? ? nil : 'Please provide an engine option to use. you can choose between `google`, `bing`, or `both`.'
    @errors << err
  end
end