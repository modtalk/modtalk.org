module UrlHelper
  def docs_path(path=nil, version='latest')
    domain = if Rails.env.production? then 'http://docs.modtalk.org' else 'http://docs.modtalk.devvm' end
    if path.nil? then
      domain
    else
      "#{domain}/#{version}/#{path}"
    end
  end
  def blog_path
    ModtalkWebsite::Config.blog_domain
  end
  def pm_project_path(project='modtalk')
    if project.nil? then
      'https://pm.modtalk.org'
    else
      "https://pm.modtalk.org/projects/#{project}"
    end
  end
  def issue_path(id)
    "https://pm.modtalk.org/issues/#{id}"
  end
  def github_path(repo=nil)
    if repo.nil? then
      'https://github.com/modtalk'
    else
      "https://github.com/modtalk/#{repo}"
    end
  end
  def facebook_path
    'https://facebook.com/modtalkgroup'
  end
  def twitter_path
    'https://twitter.com/ModtalkGroup'
  end
end
