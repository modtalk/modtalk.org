class DefaultController < ApplicationController
  def index
    resp = Net::HTTP.get(URI.parse("#{blog_path}/?feed=rss2"))
    @rss = SimpleRSS.parse resp
  end

  def license
  end
end
