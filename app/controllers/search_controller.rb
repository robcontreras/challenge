# frozen_string_literal: true

# The SearchController class represents...
class SearchController < ApplicationController

  def index
    engine = search_params[:engine]
    query = search_params[:text]
    render json: SearchProcessor.new(engine, query).execute, status: :ok
  end

  # Private methods
  private

  # desc
  def search_params
    params.permit(:engine, :text)
  end
end