#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#version = 5.5

version = node["mysql"]["version"]
mysql_conf_bath = "/etc/my.cnf"

#mysql has already installed  => remove
if version != '5.5'
  bash "remove_installed_mysql" do
    only_if "yum list installed | grep mysql*"
    user "root"
  
    code <<-EOH
      yum remove -y mysql*
    EOH
  end
end

package "mysql" do
  action :install #このままだとデフォルトバージョンインストールになるお
#  options "--enablerepo=mysql55-community"
end



C
