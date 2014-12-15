module DownloadHelper
  def latest_download_link
    link_to 'Latest Version', download_root_path
  end
end