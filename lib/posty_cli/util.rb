#Util class is required for all core requirements and autoload it

module PostyCli
	module Util


		autoload :Domain, 		'posty_cli/util/domain'
		autoload :User, 		'posty_cli/util/user'
		autoload :Alias, 		'posty_cli/util/alias'

		autoload :RestClient, 	'rest_client'
		autoload :URI, 			'uri'
		autoload :Socket,		'socket'
		autoload :JSON, 		'json'

		def self.build_uri(name)
			URI.join(PostyCli::Config[:posty_api_url], PostyCli::Config[:posty_api_version] + "/", name).to_s
		end

		def self.check_name(name)
			split = name.split("\@")
			if(name =~ /\@/ && split.length < 3)
				return true
			else 
				return false
			end
		end

		def self.check_url(domain)
			puts "You have to enter a valid URL. You should read http://de.wikipedia.org/wiki/Uniform_Resource_Locator. Because #{domain} cant be a valid domain name"
		end
		


		def self.check_response_code(response, mes)
			

			if response =~ /401/
				## Unauthorized 
				puts "User token was not present or is not valid."
				exit 1 
			elsif response =~ /400/
				##name already taken
				mes = JSON.parse(mes)
				mes["error"].each do |key, value|
					value.each do |value|
						puts key + ": " + value
					end
				end
			elsif response =~ /403/ 
				## Forbidden 
				puts "You are not authorized to complete this action"
				exit 1 
			elsif response =~ /404/ 
				## Not found 
				
				if(mes =~ /\{/)
					mes2 = JSON.parse(mes)
					puts "an error occurred: " + mes2["error"]
					exit 1
				else
					puts "URL " + mes 
					exit 1
				end


			elsif response =~ /405/ 
				## Method not allowed 
				puts "This request is not supported."
				exit 1 
			elsif response =~ /409/
				## Conflicting resource  
				puts "A conflicting resource already exists."
				exit 1 
			elsif response =~ /500/
				## Server error
				puts "Oops.  Something went wrong. Please try again."
			end
		end
	end
end