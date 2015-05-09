class DefaultController < ApplicationController
  def index
    resp = Net::HTTP.get(URI.parse('http://blog.modtalk.org/?feed=rss2'))
    @rss = SimpleRSS.parse resp

  end

  def license
  end
end
