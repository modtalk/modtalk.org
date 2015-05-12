Rails.application.routes.draw do
  root 'default#index'
  get 'index' => 'default#index'
  get 'news' => 'news#index'
  get 'license' => 'default#license'
  get 'search' => 'search#search'
  mount BeaconProxy.new, at: '/monitor'
  namespace 'newsletter' do
    post 'subscribe'
    get 'unsubscribe'
  end
  namespace 'contribute' do
    root action: :index
    get 'donate'
    get 'report_bug'
  end
  namespace 'download' do
    root action: :index
    get ':version/:platform', format: false, constraints: {
      version: /[0-9.]+|latest|nightly/
    }, action: 'download_file'
    get ':version/:platform.:format', constraints: {
      version: /[0-9.]+|latest|nightly/,
      format: /[a-z.]{2,6}/
    }, action: 'fetch_file', as: 'fetch'
  end
end
