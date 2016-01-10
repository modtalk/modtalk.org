module ModtalkWebsite
  module Config
    @config = nil
    public
    class << self
      def load
        yaml = YAML.load_file("#{Rails.root}/config/configuration.yml")

        @config = HashWithIndifferentAccess.new yaml
      end

      def method_missing(method, *args, &block)
        load unless @config
        @config[method]
      end
    end
  end
end