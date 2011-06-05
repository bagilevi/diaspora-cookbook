# Checkout code, start/restart services
deploy_dir = node[:diaspora][:path]

gem_package "bundler" do
  version "~> 1.0.14"
end

include_recipe "git"

restart_services = bash "restart-services" do
  user "root"
  cwd "/tmp"
  code <<-CODE
    #{node[:diaspora][:thins][:ports].each do |port|
      "sv restart diaspora-thin-#{port}"
    end.join("\n")}
    sv restart diaspora-websocket
  CODE
  action :nothing
end

directory "#{deploy_dir}/shared/config" do
  recursive true
  owner "diaspora"
  group "diaspora"
  mode 0755
end

directory "#{deploy_dir}/shared/log" do
  recursive true
  owner "diaspora"
  group "diaspora"
  mode 0755
end

file "#{deploy_dir}/shared/log/production.log" do
  owner "diaspora"
  group "diaspora"
  mode "0755"
  action :touch
end


directory "#{deploy_dir}/shared/pids" do
  recursive true
  owner "diaspora"
  group "diaspora"
  mode 0755
end

template "#{deploy_dir}/shared/config/database.yml" do
  source "database.yml.erb"
  owner "root"
  group "diaspora"
  mode 0640
  variables :db => node[:diaspora][:database],
    :environment => node[:diaspora][:platform]
  notifies :run, restart_services
end

template "#{deploy_dir}/shared/config/application.yml" do
  source "application.yml.erb"
  owner "root"
  group "diaspora"
  mode 0640
  variables :url => "http#{'s' if node[:diaspora][:enable_ssl]}://#{node[:diaspora][:domain]}",
            :platform => node[:diaspora][:platform]

  notifies :run, restart_services
end

template "#{deploy_dir}/shared/config/secret_token.rb" do
  source "secret_token.rb.erb"
  owner "root"
  group "diaspora"
  mode 0640
  variables :token => node[:diaspora][:rails_secret_token]
  notifies :run, restart_services
end

template "#{deploy_dir}/shared/config/oauth_keys.yml" do
  source "oauth_keys.yml.erb"
  owner "root"
  group "diaspora"
  mode 0640

  variables :oauth_keys => node[:diaspora][:oauth_keys]

  notifies :run, restart_services
end

directory "#{deploy_dir}/shared/uploads" do
  recursive true
  owner "diaspora"
  group "diaspora"
  mode 0755
end

deploy_revision deploy_dir do
  action node[:diaspora][:deploy_mode]
  repository node[:diaspora][:repository]
  revision node[:diaspora][:revision]
  user "diaspora"
  group "diaspora"


  symlinks = {
    "config/database.yml" => "config/database.yml",
    "config/application.yml" => "config/application.yml",
    "config/oauth_keys.yml" => "config/oauth_keys.yml",
    "config/secret_token.rb" => "config/initializers/secret_token.rb",
    "uploads" => "public/uploads",
    "log" => "log",
  }

  purge_before_symlink symlinks.values
  symlink_before_migrate symlinks


  migrate true
  migration_command "bundle exec rake db:migrate"

  environment "RAILS_ENV" => node[:diaspora][:platform]

  before_migrate do
    bash "install-bundled-gems" do
      cwd release_path
      user "diaspora"
      code <<-CODE
        bundle install --path #{deploy_dir}/shared/bundled_gems --without development,test
      CODE
    end
  end
  

  before_symlink do
    bash "package-assets" do
      cwd release_path
      user "diaspora"
      code <<-CODE
        bundle exec sass --update public/stylesheets/sass:public/stylesheets
        bundle exec jammit
      CODE
    end
  end

  notifies :run, restart_services
end


