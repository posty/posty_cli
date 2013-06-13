module PostyCli
	module Command
		class Domain < Thor

			#SHOW
			map "-l" => "list"
			map "--list" => "list"

			desc "list", "list all domains"
			long_desc <<-D 
				List all of the domains from your server
			D

			def list
				out = PostyCli::Util::Domain.get_all
				print_table(out)
			end



			#ADD
			desc "add [DOMAIN]", "add a domain"
			long_desc <<-D 
			Add a domain to your server. You have to specify a name to create a domain.
			[DOMAIN] need to be specified with the regular expressions to a Domain. 
			$ posty domain add posty-soft.com 
			D
			def add(name)
				json = {name: name}.to_json
				PostyCli::Util::Domain.create(json, name)
			end

			#EDIT
			desc "edit [DOMAIN][NEW_DOMAIN]", "edit a specified domain"
			long_desc <<-D 
			Edit a specified domain on the server. You have to enter [DOMAIN] and the [NEW_DOMAIN] 
			which include the new name of the domain. 
			D
			def edit(name, new_name)
				json = {name: new_name}.to_json
				PostyCli::Util::Domain.edit(name, json, new_name)
			end

			#DELETE
			desc "delete [DOMAIN]", "delete a specified domain"
			long_desc <<-D 
			Delete a specified domain on the server. You have to specify the domain you 
			would delete. [DOMAIN] will delete from the server entirely.
			D
			def delete(name)
				if(yes? "Are you sure you want to delete #{name}? Yes\\No")
				PostyCli::Util::Domain.delete(name)				
				end
			end
		end
	end
end