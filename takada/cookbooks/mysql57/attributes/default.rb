default[:mysql][:mysql75_url] = 'http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm'
default[:mysql][:innodb_buffer_pool_size_ratio] = '0.6'
default[:mysql][:query_cache_type] = 'ON'
default[:mysql][:query_cache_limit] = '1M'
default[:mysql][:query_cache_size] = '128M'
default[:mysql][:sort_buffer_size] = '2M'
default[:mysql][:read_rnd_buffer_size] = '2M'
default[:mysql][:max_connections] = '256'
default[:mysql][:innodb_io_capacity] = '2000'
default[:mysql][:long_query_time] = '20'
default[:mysql][:expire_logs_days] = '7'
default[:mysql][:backup] = false
default[:mysql][:user_info] = nil
default[:mysql][:character_set_server] = 'utf8'
default[:mysql][:collation_server] = 'utf8_general_ci'
default[:mysql][:interactive_timeout] = '60'
default[:mysql][:wait_timeout] = '60'


#default root password
default[:mysql][:default_password] = 'password'

#load data bag
user_root = Chef::EncryptedDataBagItem.load("users","root")
#user = Chef::DataBagItem.load("passwords","mysql")
default[:mysql][:root_user] = user_root['id']
default[:mysql][:root_password] = user_root['pass']

user_normal = Chef::EncryptedDataBagItem.load("users","takada")
default[:mysql][:normal_user] = user_normal['id']
default[:mysql][:normal_password] = user_normal['pass']

default[:mysql][:update_password] = '@Dtech00'
