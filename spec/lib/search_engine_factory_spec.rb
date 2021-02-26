# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search Engine Factory' do
  it 'creates a Google Engine instance' do
    google_instance = SearchEngineFactory.from_string('google')
    expect(google_instance).to be_a SearchEngines::GoogleEngine
  end

  it 'creates a Bing Engine instance' do
    google_instance = SearchEngineFactory.from_string('bing')
    expect(google_instance).to be_a SearchEngines::BingEngine
  end

  it 'raises an error when an invalid string is passed' do
    expect{ SearchEngineFactory.from_string('googl') }.to raise_error(ArgumentError)
  end
end