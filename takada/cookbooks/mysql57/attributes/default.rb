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
default[:mysql][:collation_server] = 'utf8'
default[:mysql][:interactive_timeout] = '60'
default[:mysql][:wait_timeout] = '60'

#load data bag
user = Chef::EncryptedDataBagItem.load("users","root")
#user = Chef::DataBagItem.load("passwords","mysql")
default[:mysql][:root_user] = user['id']
default[:mysql][:root_password] = user['pass']

default[:mysql][:default_password] = '@Dtech00'
