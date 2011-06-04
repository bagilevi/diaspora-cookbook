# ImageMagick
package "imagemagick"
package "libmagickwand-dev"

include_recipe "diaspora::deploy"

node[:diaspora][:thins][:ports].each do |port|

  runit_service "diaspora-thin-#{port}" do
    template_name 'thin'
    options :dir => "#{node[:diaspora][:path]}/current",
            :platform => node[:diaspora][:platform],
            :port => port
    restart_command 'kill'
  end

end

