maintainer        "Levente Bagi"
maintainer_email  "bagilevi@gmail.com"
license           "AGPL 3.0"
description       "Sets up a Diaspora pod"
version           "0.0.1"

depends "java"
depends "mysql"
depends "apache2"
depends "git"

recipe "diaspora", "Sets up all diaspora services on one node"
recipe "diaspora::database", "Installs database server (mysql-server)"
recipe "diaspora::web_backend", "Installs the web app servers (thin)"
recipe "diaspora::web_fontend", "Install the web front-end (apache2)"


%w{ ubuntu }.each do |os|
  supports os
end

