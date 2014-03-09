# app/tmpフォルダのパーミッション変更
bash 'change tmp permission' do
  user 'root'
  code <<-EOC
    mkdir #{node[:httpd][:docroot]}/app/tmp
    chmod 777 #{node[:httpd][:docroot]}/app/tmp
  EOC
end

bash 'get Debug-Kit' do
  user 'root'
  code <<-EOC
    cd #{node[:httpd][:docroot]}/app/Plugin
    rm -rf debug_kit
    git clone https://github.com/cakephp/debug_kit.git
  EOC
end

template 'Config/core.php' do
  path "#{node[:httpd][:docroot]}/app/Config/core.php"
  source 'core.php'
  mode 0644
end

template 'Config/bootstrap.php' do
  path "#{node[:httpd][:docroot]}/app/Config/bootstrap.php"
  source 'bootstrap.php'
  mode 0644
end

template 'Config/database.php' do
  path "#{node[:httpd][:docroot]}/app/Config/database.php"
  source 'database.php'
  mode 0644
end

template 'Controller/AppController.php' do
  path "#{node[:httpd][:docroot]}/app/Controller/AppController.php"
  source 'AppController.php'
  mode 0644
end

include_recipe 'database::mysql'

mysql_connection_info = {:host => 'localhost',
                         :username => 'root',
                         :password => 'cakepass'}

%w(cakephp cakephp_test).each do |db|
  mysql_database db do
    connection mysql_connection_info
    action :create
  end
end

