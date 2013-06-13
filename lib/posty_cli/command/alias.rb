module PostyCli
	module Command
		class Alias < Thor
			#SHOW
			map "-l" => "list"
			map "--list" => "list"

			desc "list[DOMAIN]", "lists all aliases"
			long_desc <<-D 
				List all of the alias in the specified domain
			D

			def list(domain)
				out = PostyCli::Util::Alias.get_all(domain)
				print_table(out)
			end



			#ADD
			desc "add [USER]@[DOMAIN] [ALIAS]", "add an alias"
			long_desc <<-D 
			Add an alias to a specified user. You have to specify a name and the domain to create a alias.
			[ALIAS] need to be specified with the regular expressions to an User because its the restriction for email adress. 
			$ posty alias add test@posty-soft.com test2
			D
			def add(name, ali)
				split = name.split("\@")
				if(PostyCli::Util::check_name(name))									
					json = {source: ali, destination: split[0]}.to_json				
					PostyCli::Util::Alias.create(json, name, split[1], ali)									
				else
					puts "you have to enter a valid email adress, like test@posty-soft.de"
				end
			end

			#EDIT
			desc "edit [ALIAS]@[DOMAIN] [NEW_ALIAS]", "edit an specified user"
			long_desc <<-D 
			Edit a specified alias on the domain. You have to enter [USER]@[DOMAIN] and the [NEW_ALIAS] 
			which include the new name of the alias. 
			$ posty alias edit test2@posty-soft.com test3
			D
			def edit(name, new_name)
				split = name.split("\@")
				if(name =~ /\@/ && split.length < 3 )
					domain = split[1]
					old_name = split[0]
					json = {source: new_name}.to_json
					PostyCli::Util::Alias.edit(json, domain, new_name, old_name, new_name)								
				else
					puts "you have to enter a valid email adress like test@posty-soft.de"
				end
			end

			#DELETE
			desc "delete [ALIAS]@[DOMAIN]", "delete a specified alias from the given user"
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
						PostyCli::Util::Alias.delete(name_del, domain)				
					end
				end
			end
		end
	end
end