# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search', type: :request do
  context 'GET /' do
    it 'should route to the search controller' do
      get root_url
      expect(response).to be_successful
    end
  end

  context 'GET /search' do
    describe 'with an invalid parameters' do
      it 'returns an error when the engine is missing' do
        get search_url, params: { text: 'synak' }
        result = JSON.parse(response.body)
        expect(result['errors']).to eq('Please provide an engine option to use. you can choose between `google`, `bing`, or `both`.')
      end

      it 'returns an error when the engine is not valid' do
        get search_url, params: { engine: 'yahoo', text: 'synak' }
        result = JSON.parse(response.body)
        expect(result['errors']).to eq('The engine string provided is not a valid search engine.')
      end

      it 'returns an error when the text is missing' do
        get search_url, params: { engine: 'google' }
        result = JSON.parse(response.body)
        expect(result['errors']).to eq('Please provide a text to search for.')
      end
    end

    describe 'with valid parameters' do
      it 'returns results when the engine is `google`' do
        get search_url, params: { engine: 'google', text: 'synak'}
        result = JSON.parse(response.body)
        expect(response.code).to eq '200'
        expect(result.length).to be > 0
      end

      it 'returns results when the engine is `bing`' do
        get search_url, params: { engine: 'bing', text: 'synak'}
        result = JSON.parse(response.body)
        expect(response.code).to eq '200'
        expect(result.length).to be > 0
      end

      it 'returns results when the engine is `both`' do
        get search_url, params: { engine: 'google', text: 'synak'}
        result = JSON.parse(response.body)
        expect(response.code).to eq '200'
        expect(result.length).to be > 0
      end
    end
  end
end