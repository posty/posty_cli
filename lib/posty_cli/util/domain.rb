module PostyCli
	module Util
		class Domain

			#Get all Domains
			def self.get_all()
				@tabletmp = []
				begin
					url = PostyCli::Util.build_uri("domains")
					response = RestClient.get (url)
				rescue SocketError => e #error for no network connection
					puts "Could not contact the server. Please check connectivity!"
					exit 1
				rescue URI::Error => e
					PostyCli::Util.check_url(url)
				rescue Exception => e #error that pass the http code and the message to the Util class
					PostyCli::Util.check_response_code(e.message, e.response)				
				end	
				data = JSON.parse(response)
				data.each do |blub|
					@tabletmp << blub["virtual_domain"]["name"]
				end
				tablesel = @tabletmp.map.with_index{ |a, i| [i+1, *a]}
				
			end
			#ADD
			def self.create(name, screen)
				begin
					url = PostyCli::Util.build_uri("domains")
					response = RestClient.post(url, 
						name, :content_type => :json, :accept => :json)
						puts "Domain #{screen} is created"

				rescue SocketError => e #error for no network connection
					puts "Could not contact the server. Please check connectivity!"
					exit 1
				rescue URI::Error => e
					PostyCli::Util.check_url(url)
				rescue Exception => e #error that pass the http code and the message to the Util class
					PostyCli::Util.check_response_code(e.message, e.response)				
				end				
			end 

			def self.delete(name)
                begin 
					url = PostyCli::Util.build_uri("domains/#{name}")
                    response = RestClient.delete(url) 
                    puts "domain #{name} is deleted"

				rescue SocketError => e
					puts "Could not contact the server. Please check connectivity!"
					exit 1
				rescue Exception => e 
					PostyCli::Util.check_response_code(e.message, e.response )
                end
			end

			def self.edit(name, new_name, screen)
				begin
					url = PostyCli::Util.build_uri("domains/#{name}")
					response = RestClient.put(url, new_name, :content_type => :json, :accept => :json)
					puts("you have edit the domain #{name} into #{screen}")
				rescue SocketError => e
					puts "Could not contact the server. Please check connectivity!"
					exit 1
				rescue Exception => e
					PostyCli::Util.check_response_code(e.message, e.response )
				end
			end
		end
	end
end
