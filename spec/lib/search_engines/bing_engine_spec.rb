# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bing Engine' do
  let(:engine) { SearchEngineFactory.from_string(SearchEngineFactory::BING) }

  context 'with valid credentials' do
    before do
      allow_any_instance_of(SearchEngines::BingEngine).to receive(:search).with(anything).and_return(
        OpenStruct.new(code: 200, body: '')
      )
    end

    it 'performs a search for a query' do
      response = engine.search('test')
      expect(response.code).to eq 200
    end
  end

  context 'with invalid credentials' do
    before do
      allow_any_instance_of(SearchEngines::BingEngine).to receive(:search).with(anything).and_return(
        OpenStruct.new(code: 403, body: '')
      )
    end

    it 'receives an error from the server' do
      response = engine.search('test')
      expect(response.code).to eq 403
    end
  end
end