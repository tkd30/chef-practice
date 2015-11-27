#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

filename = "mysql57-community-release-el6-7.noarch.rpm"

remote_file "/tmp/#{filename}" do
  source "http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm"
  checksum = "1cbcf6b4ae7592b9ac100d9e7cd2ceb4"
end

package "mysql" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{filename}"
end

execute "mysql-community.repo" do
  command "/bin/sed -i -e 's/^enabled\s*=\s*1/enabled=0/g' /etc/yum.repos.d/mysql-community.repo"
  action :nothing
  subscribes :run, "package[mysql]", :immediately
end

yum_package "mysql" do
    action :install
    options "--enablerepo=#{node['mysql']['version']}"
end
