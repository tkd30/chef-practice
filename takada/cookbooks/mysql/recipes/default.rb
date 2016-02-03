#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

##################################################################
# rpmファイルをDLしてインストールするやり方                      #
##################################################################
#filename = "mysql-community-release-el6-5.noarch.rpm"
#
#remote_file "/tmp/#{filename}" do
#  source "http://dev.mysql.com/get/#{filename}"
#  checksum = "1cbcf6b4ae7592b9ac100d9e7cd2ceb4"
#end

#package "mysql" do
#  action :install
#  provider Chef::Provider::Package::Rpm
#  source "/tmp/#{filename}"
#end

#execute "mysql-community.repo" do
#  command "/bin/sed -i -e 's/^enabled\s*=\s*1/enabled=0/g' /etc/yum.repos.d/mysql-community.repo"
#  action :nothing
#  subscribes :run, "package[mysql]", :immediately
#end
#
#yum_package "mysql" do
#    action :install
#    options "--enablerepo=#{node['mysql']['version']}"
#end


##################################################################
# yumインストールのやり方                                        #
##################################################################
package "mysql-community-server" do
  version "#{node[:mysql][:version]}"
	action :install
  options "--enablerepo=mysql56-community"
  not_if "rpm -qa | grep mysql-community-server"
end
