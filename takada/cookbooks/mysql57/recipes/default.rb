#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

yum_repository 'mysql57-community' do
  description "MySQL 5.7 Community Server"
  baseurl node[:mysql][:mysql75_url]
  enabled false
  gpgcheck false
  sslverify false
  timeout '10'
  action :create
end

package "mysql-community-server" do
  version "#{node[:mysql][:version]}"
  action :install
  options "--enablerepo=mysql57-community"
end

template "/etc/my.cnf" do
    source "etc/my.cnf.erb"
    mode 0644
    owner "root"
    group "root"
end

service "mysqld" do
  action [ :start, :enable ]
end
