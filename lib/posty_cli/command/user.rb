require 'io/console'
module PostyCli
	module Command
		class User < Thor
			#SHOW
			map "-l" => "list"
			map "--list" => "list"

			desc "list [DOMAIN]", "list all users"
			long_desc <<-D 
				List all of the user in the specified domain
			D

			def list(domain)
				out = PostyCli::Util::User.get_all(domain)
	
				print_table(out)
				
			end



			#ADD
			desc "add [USER]@[DOMAIN]", "add an user"
			long_desc <<-D 
			Add an User to a specified domain. You have to specify a name and the domain to create a user.
			[USER] need to be specified with the regular expressions to an User because its the restriction for email adress. 
			$ posty user add posty-soft.com 
			D
			def add(name)
				split = name.split("\@")
				if(name =~ /\@/ && split.length < 3 )
					i = true
					while i		
									
						
						puts "password:"
						pw = STDIN.noecho(&:gets).chomp	
						puts "enter password again: "							
						if(STDIN.noecho(&:gets).chomp==pw)
							json = {name: split[0], password: pw}.to_json
							domain = split[1]
							
							PostyCli::Util::User.create(json, domain, split[0])
							i=false
						else
							puts "password not equal, sorry!!"
						end
					end					
				else
					puts "you have to enter a valid email adress like test@posty-soft.de"
				end
			end

			#EDIT
			desc "edit [USER]@[DOMAIN] [NEW_USER]", "edit an specified user"
			long_desc <<-D 
			Edit an specified user on the domain. You have to enter [USER]@[DOMAIN] and the [NEW_USER] 
			which include the new name of the user. 
			D
			def edit(name, new_name)
				split = name.split("\@")
				if(name =~ /\@/ && split.length < 3 )
					i = true
					while i		
						puts "password:"
						pw = STDIN.noecho(&:gets).chomp	
						puts "enter password again: "							
						if(STDIN.noecho(&:gets).chomp==pw)
							json = {name: new_name, password: pw}.to_json
							domain = split[1]
							
							PostyCli::Util::User.edit(json, domain, new_name, split[0], new_name)
							i=false
						else
							puts "password not equal, sorry!!"
						end
					end					
				else
					puts "you have to enter a valid email adress like test@posty-soft.de"
				end
			end

			#DELETE
			desc "delete [USER]@[DOMAIN]", "delete a specified user from the given domain"
			long_desc <<-D 
			Delete a specified user on the server. You have to specify the domain you 
			would the user delete. [USER] will delete from the server entirely.
			D
			def delete(name)
				split = name.split("\@")
				if(name =~ /\@/ && split.length < 3 )
					name_del = split[0]
					domain = split[1]
					if(yes? "Are you sure you want to delete #{name}? Yes\\No")
						PostyCli::Util::User.delete(name_del, domain)				
					end
				end
			end
		end
	end
end