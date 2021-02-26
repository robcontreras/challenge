# frozen_string_literal: true

# The SearchController class represents the controller where all the available endpoints are defined
class SearchController < ApplicationController

  # Main endpoint where the search will be conducted.
  def index
    engine = search_params[:engine]
    query = search_params[:text]
    render json: SearchProcessor.new(engine, query).execute, status: 200
  end

  private

  # Specifies which params are permitted.
  def search_params
    params.permit(:engine, :text)
  end
end