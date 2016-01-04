#
# Cookbook Name:: mysql57
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
filename = "mysql57-community-release-el6-7.noarch.rpm"

remote_file "/tmp/#{filename}" do
  source "https://dev.mysql.com/get/#{filename}"
  checksum = "4c4d512821c9cdbb8987d1942db84d11"
end

package "mysql" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{filename}"
end

execute "mysql-community.repo" do
  command "/bin/sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/mysql57-community.repo"
  action :nothing
  subscribes :run, "package[mysql*]", :immediately
end

%w{
mysql-community-client
mysql-community-server
}.each do |package_name|
  package "#{package_name}" do
    action :install
    options "--enablerepo=mysql57-community"
  end
end

#my.cnf配置
template "/etc/my.cnf" do
  source "etc/my.cnf.erb"
  mode 0644
  owner "root"
  group "root"
# 更新されたらrootパスワード変更を実行 
#  notifies :run, 'script[set_root_password]', :delayed
end

#service "mysqld" do
#  action [ :start, :enable ]
#end

#mysqlサーバー初期設定
#script "first_password" do
#  interpreter "bash"
#  user "root"
#  cwd "/var/log/"
#  code <<-EOH
#  EOH
#end

#rootユーザーの作成
#user "#{node[:mysql][:normal_user]}" do
#  home "/home/#{node[:mysql][:normal_user]}"
#	action :create
#end

#mysql password setting
#script "set_root_password" do
#  action :nothing
#  interpreter 'bash'
#  user 'root'
#  code <<-EOH
#    mysql -u #{node[:mysql][:root_user]} -p#{node[:mysql][:default_password]} -e "ALTER USER '#{node[:mysql][:root_user]}'@'localhost' IDENTIFIED BY '#{node[:mysql][:root_pass]}'     "
#  EOH
#end
