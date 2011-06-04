include_recipe "diaspora::bootstrap"
include_recipe "diaspora::database"
include_recipe "diaspora::deploy"
include_recipe "diaspora::web_backend"
include_recipe "diaspora::web_frontend"
include_recipe "diaspora::redis"



