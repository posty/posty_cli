require 'socket'
module PostyCli
	module Util
		class Alias
			#Get all domains
			def self.get_all(domain)
				#Array to keep the rest-output
				@tabletmp = []
				begin
					url = PostyCli::Util.build_uri("domains/#{domain}/aliases")
					#begin to prepare rest or end with a rescue 
					res = RestClient.get (url) 
					data = JSON.parse(res) 
					data.each do |blub| 
						@tabletmp << blub["virtual_alias"]["source"] +" ==> "+ blub["virtual_alias"]["destination"] +"\@"+ domain
					end 

				rescue SocketError => e #error for no network connection
					puts "Could not contact the server. Please check connectivity!"
					exit 1
				rescue URI::Error => e
					PostyCli::Util.check_url(domain)
				rescue Exception => e #error that pass the http code and the message to the Util class			
					
					PostyCli::Util.check_response_code(e.message, e.response)				
				end	
				#output the Domains with index
			
				tablesel = @tabletmp.map.with_index{ |a, i| [i+1, *a]}
				
				
			end

			#ADD a alias to a user
			def self.create(json, email, domain, screen)
				begin
					#begin to prepare rest or end with a rescue
					url = PostyCli::Util.build_uri("domains/#{domain}/aliases")
					res = RestClient.post(url, json, :content_type => :json, :accept => :json)
					puts "Alias #{screen} for #{email} is created"
						
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
                	url = PostyCli::Util.build_uri("domains/#{domain}/aliases/#{name}")                    
                    res = RestClient.delete(url) 
                    puts "the alias #{name} is deleted"
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
					url = PostyCli::Util.build_uri("domains/#{domain}/aliases/#{old}")
					res = RestClient.put(url, json, :content_type => :json, :accept => :json)
					puts("you have edit the alias #{old} into #{screen}")
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
