maintainer        "Levente Bagi"
maintainer_email  "bagilevi@gmail.com"
license           "Apache 2.0"
description       "Sets up a Diaspora pod"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README'))
version           "0.0.1"

depends "java"
depends "mysql"
depends "apache2"
depends "git"

recipe "diaspora", "Sets up all diaspora services on one node"
recipe "diaspora::database", "Installs database server (mysql-server)"
recipe "diaspora::web_backend", "Installs the web app servers (thin)"
recipe "diaspora::web_fontend", "Install the web front-end (nginx)"


%w{ ubuntu }.each do |os|
  supports os
end

