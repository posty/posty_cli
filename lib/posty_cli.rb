#posty_cli is the main file to load all required gems and classes
require 'yaml'
require 'thor/shell/basic'
require 'thor/shell/color'
module PostyCli 


	autoload :Command,			'posty_cli/command'
  autoload :Config,       'posty_cli/config'
	autoload :Version, 			'posty_cli/version'
	autoload :RestClient,   'rest-client'
	autoload :JSON,         'json'
	autoload :Util,         'posty_cli/util'
  

  CONFIG_PATH = '~/.posty.yml'
  config = File.expand_path(CONFIG_PATH)
 

  unless File.exist?(config)
    File.open(File.expand_path(File.dirname(__FILE__) + "/../config.yml.sample", "r")) do |sample|
      puts"Could not find a config file. Create a config file, '#{CONFIG_PATH}', form the following sample config"
      
      puts("=" *15 + "END (Do not copy this line " + "=" *15)
        while(line = sample.gets)
          puts line
        end
        puts("="*15 + " END (Do not copy this line) "+ "=" *15)
      end
      exit(-1)
    end
    PostyCli::Config.load(config)
end

