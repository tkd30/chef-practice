# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2014, Takada_Mio@CyberAgent,Inc.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'httpd::php'

package "httpd" do
  action :install
end

template "/var/www/html/ip.html" do
  source "var/www/html/ip.html.erb"
  mode 0644
end

template "/var/www/html/node.html" do
  source "var/www/html/node.html.erb"
  mode 0644
end

service "httpd" do
  action [ :start, :enable]
end
