# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2014, Takada_Mio@CyberAgent,Inc.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'httpd'

directory "/var/www/html/php" do
  mode 0755
  action :create
end

cookbook_file "/var/www/html/php/info.php" do
  source "/var/www/html/php/info.php"
  mode 0644
end
