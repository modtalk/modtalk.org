class SearchController < ApplicationController
  def search
    if params[:query].nil? then
      @results = []
    else
      @results = Page.search(params[:query])
    end

    respond_to do |format|
      format.html
      format.json {
        render json: @results
      }
    end
  end
end