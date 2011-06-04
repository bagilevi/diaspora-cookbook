# Diaspora Cookbook

Cookbook for installing the [DIASPORA*](github.com/diaspora/diaspora)
distributed social networking application.

Tested on Ubuntu 10.04.

## Easy setup

See [diaspora-setup](https://github.com/bagilevi/diaspora-setup).

## Setup with Opscode Platform

Follow the steps in http://wiki.opscode.com/display/chef/Quick+Start

Inside the chefrepo run:

    knife cookbook vendor apache2
    knife cookbook vendor apt
    knife cookbook vendor build-essential
    knife cookbook vendor git
    knife cookbook vendor java
    knife cookbook vendor openssl
    knife cookbook vendor redis
    knife cookbook vendor runit
    curl -L https://github.com/downloads/bagilevi/mysql-cookbook/mysql.tgz | tar xzvf - -C cookbooks
    curl -L https://github.com/downloads/bagilevi/diaspora-cookbook/diaspora.tgz | tar xzvf - -C cookbooks

Type `knife node list` to check if the new node is there. The hostname here
might be different from what you use to access it.

Then run:

    knife cookbook upload diaspora apt build-essential git java mysql apache2 openssl runit
    knife node run_list add NODE 'recipe[diaspora]'

On the server as root:

Restart the chef-client service:

    sudo /etc/init.d/chef-client restart

Or to run it in debug mode, stop the service and run it manually (then start the service when you're finished):

    sudo /etc/init.d/chef-client stop
    sudo /usr/bin/ruby1.8 /usr/bin/chef-client -P /var/run/chef/client.pid -l debug -c /etc/chef/client.rb
    # ...
    sudo /etc/init.d/chef-client start

## License

Authors: Levente Bagi, some code was used from [DIASPORA*](https://github.com/diaspora/diaspora).

Licensed under the [GNU Affero General Public License Version 3](http://www.gnu.org/licenses/agpl-3.0.html).


