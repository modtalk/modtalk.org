module ModtalkWebsite
  module Config
    @config = nil
    public
    class << self
      def load
        yaml = YAML.load_file("#{Rails.root}/config/configuration.yml")
        @config = {}
        if yaml.is_a?(Hash)
          @config.merge!(yaml['default']) if yaml['default']
          @config.merge!(yaml[Rails.env]) if yaml[Rails.env]
        end

        @config = HashWithIndifferentAccess.new(@config)
      end

      def method_missing(method, *args, &block)
        load unless @config
        @config[method]
      end
    end
  end
end