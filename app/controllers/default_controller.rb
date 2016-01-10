class DefaultController < ApplicationController
  def index
    resp = Net::HTTP.get(URI.parse("#{ModtalkWebsite::Config.blog_domain}/?feed=rss2"))
    @rss = SimpleRSS.parse resp
  end

  def license
  end
end
