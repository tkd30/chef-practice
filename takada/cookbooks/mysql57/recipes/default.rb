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
end

service "mysqld" do
  action [ :start, :enable ]
  notifies :run, 'script[first_password]', :immediately
end

#初期パスワードの変更（初回だけ実行）
script "first_password" do
  interpreter "bash"
	flags "-e"
  user "root"
  cwd "/var/log/"
  code <<-EOH
    PASSWORD=`cat /var/lib/mysql/error.log | grep password $1 | cut -d " " -f 11`
    mysql -uroot -p${PASSWORD} --connect-expired-password -e "SET PASSWORD FOR root@localhost='#{node[:mysql][:update_password]}';"
    mysql -uroot -p#{node[:mysql][:update_password]} -e "FLUSH PRIVILEGES;"
  EOH
	action :nothing
end

#初期化パスワードを初回実行させるための中間ファイルを配置
template "/tmp/setting_password.sql" do
  path "/tmp/setting_password.sql"
	source "/tmp/setting_password.sql.erb"
	owner "root"
	group "root"
	mode  0600
	variables({
					:mysql_root_user => node[:mysql][:root_user],
					:mysql_root_pass => node[:mysql][:update_password]
	})
  notifies :run, 'script[first_password]', :immediately
end
