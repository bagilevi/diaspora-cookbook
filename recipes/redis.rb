package "redis-server"

cookbook_file "/etc/redis/redis.conf" do
  source "redis.conf"
  mode 0644
  notifies :restart, "service[redis-server]"
end

service "redis-server" do
  action :start
end

runit_service "diaspora-resque-worker" do
  template_name 'resque-worker'
  options :dir => "#{node[:diaspora][:path]}/current", :platform => node[:diaspora][:platform]
end

runit_service "diaspora-resque-web" do
  template_name 'resque-web'
  options :dir => "#{node[:diaspora][:path]}/current", :platform => node[:diaspora][:platform]
end

