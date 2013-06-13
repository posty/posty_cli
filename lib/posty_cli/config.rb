module PostyCli
  class Config
    class << self
      def load(source)
        @config = {:posty_url => nil,:display_results_in_pager => false}

        if source.is_a?(String)
          raise "Config file #{source} not found" unless File.exist?(source)
  
          config = YAML.load_file(source)
          @config.merge! config if config

        elsif source.is_a?(Hash)
          @config.merge! source
        end
      end

      def include?(key)
        @config.include?(key)
      end

      def [](key)
        @config[key]
      end

      def to_yaml
        @config.to_yaml
      end
    end
  end
end