require 'net/http'

class DefaultController < ApplicationController
  def index
    resp = Net::HTTP.get(URI.parse("#{blog_path}/feed/"))
    @rss = SimpleRSS.parse(resp).items
  rescue SocketError, Errno::ENETUNREACH, OpenSSL::SSL::SSLError => e
    @rss = nil
    Raven.capture_exception(e)
  end

  def license
  end
end
