# pcre dependency
package "libpcre3"
package "libpcre3-dev"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_balancer"
include_recipe "apache2::mod_proxy_http"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_ssl"
include_recipe "apache2"


directory "/var/log/apache2/#{node[:diaspora][:domain]}" do
  recursive true
  owner "root"
  group "root"
  mode 0755
end

www_root = '/var/www'

cookbook_file "#{www_root}/crossdomain.xml" do
  source "crossdomain.xml"
end

execute "change crossdomain.xml permissions" do
  command "chmod 755 #{www_root}/crossdomain.xml"
end


template "#{ node[:apache][:dir] }/sites-enabled/#{node[:diaspora][:domain]}" do
  source "apache-vhost.conf.erb"
  variables \
    :ports => node[:diaspora]['thins']['ports'],
    :domain => node[:diaspora]['domain'],
    :public_dir => "#{node[:diaspora][:path]}/current/public",
    :enable_ssl => node[:diaspora]['enable_ssl'],
    :cert_location => "/etc/apache2/ssl/#{node[:diaspora][:domain]}.crt",
    :key_location => "/etc/apache2/ssl/#{node[:diaspora][:domain]}.key"
  notifies :restart, "service[apache2]"
end

apache_site "diaspora"

runit_service "diaspora-websocket" do
  template_name 'websocket'
  options :dir => "#{node[:diaspora][:path]}/current",
          :platform => node[:diaspora][:platform]
end

