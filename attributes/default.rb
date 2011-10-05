default[:diaspora][:pod_name] = "Example Pod"
default[:diaspora][:domain] = domain = 'example.org'

# Name for config files, db name, etc.
# Should start with small-case letter, should only contain small-case letters, numbers, underscores
default[:diaspora][:site_name] = site_name = 'examplepod'

# Platform/environment: production / staging
default[:diaspora][:platform] = platform = 'production'

default[:diaspora][:path] = "/var/www/#{domain}"

# Public git repo to deploy from
default[:diaspora][:repository] = 'git://github.com/diaspora/diaspora.git'

# Branch/tag/commit to deploy
default[:diaspora][:revision] = 'master'

# :deploy will only deploy if there is a new commit on the branch
# :force_deploy will deploy every time chef-client is run
default[:diaspora][:deploy_mode] = :deploy

default[:diaspora][:thins][:ports] = [3001]

# If you enable ssl, make sure you have these files:
# cookbooks/diaspora/files/default/YOUR_DOMAIN.crt
# cookbooks/diaspora/files/default/YOUR_DOMAIN.key
default[:diaspora][:enable_ssl] = false

default[:diaspora][:database] = {
  :adapter => 'mysql2',
  :database => "#{site_name}_#{platform}",
  :host => 'localhost',
  :port => 3306,
  :username => 'diaspora',
  # Password must be specified when using chef-solo, either here or in
  # the attribute file (usually node.json).
  # When using chef-server (incl. Opscode Platform), it will be generated the
  # first time chef-client is run and remembered.
  #:password => '',
  :charset => 'utf8',
  :collation => 'utf8_bin',
}

default[:diaspora][:registrations_closed] = false
default[:diaspora][:invites_off] = false
default[:diaspora][:mail_from] = 'no-reply@example.org'
default[:diaspora][:google_analytics] = false

default[:diaspora][:admins] = [ 'example_user1dsioaioedfhgoiesajdigtoearogjaidofgjo' ]

default[:diaspora][:mailer][:enabled] = false

default[:diaspora][:oauth_keys] = {
  :twitter => {
    :consumer_key => '',
    :consumer_secret => ''
  },
  :facebook => {
    :app_id => '',
    :app_secret => ''
  },
  :tumblr => {
    :consumer_key => '',
    :consumer_secret => ''
  }
}


