# MySQL
include_recipe "mysql::server" # package "mysql-server"
package "libmysqlclient-dev"
package "libmysql-ruby"

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless[:diaspora][:database][:password] = secure_password


mysql_database "create app database" do
  host      "localhost"
  username  "root"
  password  node[:mysql][:server_root_password]

  action    :create_db
  database  node[:diaspora][:database][:database]
  charset   node[:diaspora][:database][:charset]
  collate   node[:diaspora][:database][:collation]
end

mysql_database "create app user and grant rights" do
  host      "localhost"
  username  "root"
  password  node[:mysql][:server_root_password]
  database  node[:diaspora][:database][:database]

  action        :create_user
  new_username  node[:diaspora][:database][:username]
  new_password  node[:diaspora][:database][:password]
  grant 'all'
end


