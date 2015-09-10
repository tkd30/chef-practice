# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2014, Takada_Mio@CyberAgent,Inc.
#
# All rights reserved - Do Not Redistribute
#

package "php" do
  action :install
end

template "/etc/php.ini" do
  source "etc/php.ini.erb"
  mode 0644
end

