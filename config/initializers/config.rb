require 'ostruct'

Rails.application.define_singleton_method("appconfig") {
	OpenStruct.new(YAML.load_file("#{Rails.root}/config/configuration.yml")[Rails.env] || {})
}

config = Rails.application.appconfig

if config.email_delivery
  config.email_delivery.each do |key, value|
    value.symbolize_keys! if value.respond_to?(:symbolize_keys)
    ActionMailer::Base.send("#{key}=", value)
  end
end