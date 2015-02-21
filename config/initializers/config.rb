require 'app/config'

email_delivery = ModtalkWebsite::Config.email_delivery
secret_key = ModtalkWebsite::Config.secret_key
resque = ModtalkWebsite::Config.resque

if email_delivery
  email_delivery.each do |key, value|
    ActionMailer::Base.send("#{key}=", value)
  end
end

if secret_key
  Rails.application.config.secret_token = secret_key
end

if resque
  Resque.redis = resque
end