# Install prerequisites for deploying and running diaspora

# Bundler deps
package "cpio"

# Nokogiri deps
package "libxml2-dev"
package "libxslt1-dev"

# Eventmachine deps
package "build-essential"


package "libssl-dev"
package "libopenssl-ruby"
package "libcurl4-openssl-dev"
package "libffi-ruby"
package "htop"
package "psmisc"
package "screen"
package "bzip2"

# Jammer deps
include_recipe "java" #package "openjdk-6-jdk"

gem_package "ruby-shadow"

user "diaspora" do
  comment "Diaspora Services"
  supports :manage_home => false
  action  [:create, :lock]
end

group "diaspora" do
  action :create
end



