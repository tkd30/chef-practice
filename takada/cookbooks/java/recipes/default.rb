#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "jdk" do
  action :install
  version node['java']['version']
  options'--enablerepo=apel'
end
