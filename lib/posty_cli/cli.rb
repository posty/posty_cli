require 'thor'
require 'posty_cli'
require 'posty_cli/version'
require 'json'
#CLI class to set the headcommands and specified where the subcommands are
module PostyCli
	class CLI < Thor
        

	    map "-v" => "version"
        map "--version" => "version"

        desc "--version", "print version"
        long_desc <<-D
		  Print the Posty CLI tool version		
        D
        def version
            puts "Posty CLI version %s" % [PostyCli::VERSION]
        end


        desc "domain [SUBCOMMAND]", "perform an action on a domain"
        long_desc <<-D 
        Perform an action on a domain. To see available subcommands use 'posty domain help' 
        D
        subcommand "domain", PostyCli::Command::Domain

        desc "user [SUBCOMMAND]", "perform an action on a user"
        long_desc <<-D 
        Perform an action on a User. To see available subcommands use 'posty user help' 
        D
        subcommand "user", PostyCli::Command::User

        desc "alias [SUBCOMMAND]", "perform an action on a alias"
        long_desc <<-D 
        Perform an action on a alias. To see available subcommands use 'posty alias help' 
        D
        subcommand "alias", PostyCli::Command::Alias
        
    end
end


