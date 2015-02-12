class DownloadController < ApplicationController
  def index
    @ua = UserAgent.parse(request.user_agent)
    @download_type = Download.first
  end

  def download_file
    @download = Download.where(params.permit(:version, :operating_system)).first
    if @download.nil? then
      render 'download/unknown_download'
    end
  end

  def fetch_file
    @download = Download.where(params.permit(:version, :operating_system, :format)).first
    if @download.nil? then
      render 'download/unknown_download'
    else
      send_file 'public/robots.txt'
    end
  end
end
