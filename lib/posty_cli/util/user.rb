require 'socket'
module PostyCli
	module Util
		class User
			#Get all Users
			def self.get_all(domain)
				#Array to keep the rest-output
				@tabletmp = []
				#begin to prepare rest or end with a rescue
				begin
					url = PostyCli::Util.build_uri("domains/#{domain}/users")
					response = RestClient.get (url)
					data = JSON.parse(response)
					data.each do |blub|
						@tabletmp << blub["virtual_user"]["name"] +"\@"+ domain
					end
				rescue SocketError => e #error for no network connection
					puts "Could not contact the server. Please check connectivity!"
					exit 1
				rescue URI::Error => e
					puts e
				rescue Exception => e #error that pass the http code and the message to the Util class
					PostyCli::Util.check_response_code(e.message, e.response )
				end
				tablesel = @tabletmp.map.with_index{ |a, i| [i+1, *a]}
			end

			#ADD a user to domain
			def self.create(json, domain, screen)
				
				begin
					#begin to prepare rest or end with a rescue
					url = PostyCli::Util.build_uri("domains/#{domain}/users")
					@response = RestClient.post(url, json, :content_type => :json, :accept => :json)
					puts "User #{screen} in #{domain} is created"
				rescue SocketError => e #error for no network connection
					puts "Could not contact the server. Please check connectivity!"
					exit 1
				rescue URI::Error => e
					PostyCli::Util.check_url(domain)
				rescue Exception => e #error that pass the http code and the message to the Util class
					PostyCli::Util.check_response_code(e.message, e.response)				
				end			
			end 

			def self.delete(name, domain)
				
                begin 
                	#begin to prepare rest or end with a rescue
                	url = PostyCli::Util.build_uri("domains/#{domain}/users/#{name}")                	
                    response = RestClient.delete(url)
                    puts "the user #{name} is deleted"
				rescue SocketError => e #error for no network connection
					puts "Could not contact the server. Please check connectivity!"
					exit 1
				rescue URI::Error => e
					PostyCli::Util.check_url(domain)
				rescue Exception => e #error that pass the http code and the message to the Util class			
					
					PostyCli::Util.check_response_code(e.message, e.response)				
				end		
			end

			#EDIT 
			def self.edit(json, domain, new_name, old, screen)				
				begin 
					#begin to prepare rest or end with a rescue
					url = PostyCli::Util.build_uri("domains/#{domain}/users/#{old}")
					response = RestClient.put(url, json, :content_type => :json, :accept => :json)					
					puts("you have edit the user #{old} into #{screen}")
				rescue SocketError => e #error for no network connection
					puts "Could not contact the server. Please check connectivity!"
					exit 1
				rescue URI::Error => e
					PostyCli::Util.check_url(domain)
				rescue Exception => e #error that pass the http code and the message to the Util class			
					
					PostyCli::Util.check_response_code(e.message, e.response)				
				end		
			end
		end
	end
end
