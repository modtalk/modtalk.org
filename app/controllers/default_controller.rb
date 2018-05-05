class DefaultController < ApplicationController
  def index
    resp = Net::HTTP.get(URI.parse("#{blog_path}/feed/"))
    @rss = SimpleRSS.parse(resp).items
  rescue SocketError, Errno::ENETUNREACH
    @rss = nil
  end

  def license
  end
end
