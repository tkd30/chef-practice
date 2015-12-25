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
  subscribes :run, "package[mysql]", :immediately
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

# ちょっとこの表記一旦保留
#yum_repository 'mysql57-community' do
#  description "MySQL 5.7 Community Server"
#  baseurl node[:mysql][:mysql75_url]
#  enabled false
#  gpgcheck false
#  sslverify false
#  timeout '10'
#  action :create
#end
#
#package "mysql-community-server" do
##  version "#{node[:mysql][:version]}"
#  action :install
##  options "--enablerepo=mysql57-community"
#end

#make my.cnf
template "/etc/my.cnf" do
  source "etc/my.cnf.erb"
  mode 0644
  owner "root"
  group "root"
end

service "mysqld" do
  action [ :start, :enable ]
end

# use data bag
secret_key = Chef::EncryptedDataBagItem.load_secret('/etc/chef/encrypted_data_bag_secret')

#load data bag
user = Chef::EncryptedDataBagItem.load("users","root")
#user = Chef::DataBagItem.load("passwords","mysql")

hoge = user['id']
fuga = user['pass']

p fuga
mysql_pass = "NewExample_passwd456$"
#p mysql_pass
script "set_root_password" do
  interpreter 'bash'
	user 'root'
	code <<-EOH
    mysql -u #{hoge} -p#{mysql_pass} -e "ALTER USER '#{hoge}'@'localhost' IDENTIFIED BY '@Dtech00'     "
	EOH
end
