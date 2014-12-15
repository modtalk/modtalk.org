class SearchController < ApplicationController
	def search
		client = Elasticsearch::Client.new
		if params[:query].nil? then
			@results = []
		else
			@results = SearchHelper.relevant_issues(client, params[:query])
		end

		respond_to do |format|
			format.html
			format.json {
				render json: @results
			}
		end
	end
end