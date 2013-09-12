###posty\_cli was replaced by posty_client thanks to iaddict https://github.com/iaddict/posty_client

#posty\_cli
The posty\_cli is the command line interface of the posty softwarestack. It is developed to administrate a mailserver based on Postfix and Dovecot.

##Requirements

You need to install ruby with the version 1.9.3 or later. 
And a working terminal.

##Installation

1. You need to type following in your terminal

``#~ gem install posty_cli``

2. Next you need to create a config file in your home directory
Path:

~.posty.yml

```
-this is the posty Url put here your url where the posty-api is stored
:posty_api_url: http://posty-api.herokuapp.com/api/
-this is the version from the posty api
:posty_api_version: v1
```

3. Now you are able to work with posty_cli

##Usage
When you have installed the posty\_cli you now able to work with the following command
``#~ posty ``
now it shows you wich commands are possible to type in.
###Example 
``#~ posty domain add test.com``
the first is our posty\_cli main command, the second is the section you would to edit, in this case it is the domain section. The third is what you would do in this section, the example shows to add a new domain. The last one is your new domainname. Very easy isn't it?

## Test
coming soon...

## Information

For more informations about posty please visit our website:
[www.posty-soft.org](http://www.posty-soft.org)

### Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as possible to help us fixing the possible bug. We also encourage you to help even more by forking and sending us a pull request.

### License

LGPL v3 license. See LICENSE for details.

### Copyright

All rights are at (C) [http://www.posty-soft.org](http://www.posty-soft.org) 2013
