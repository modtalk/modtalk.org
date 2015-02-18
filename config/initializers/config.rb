yaml = YAML.load_file("#{Rails.root}/config/configuration.yml")
@config = {}
if yaml.is_a?(Hash)
  @config.merge!(yaml['default']) if yaml['default']
  @config.merge!(yaml[Rails.env]) if yaml[Rails.env]
end

@config = HashWithIndifferentAccess.new(@config)

if @config['email_delivery']
  @config['email_delivery'].each do |key, value|
    ActionMailer::Base.send("#{key}=", value)
  end
end

if @config['secret_key']
  Rails.application.config.secret_token = @config['secret_key']
end