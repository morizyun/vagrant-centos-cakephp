# インストール
%w{mysql-server mysql-devel}.each do |p|
  package p do
    action :install
  end
end

# サーバー起動
service 'mysqld' do
  action [:start, :enable]
end

# my.cnf
template 'my.cnf' do
	path '/etc/my.cnf'
	source 'my.cnf.erb'
	mode 0644
	notifies :restart, 'service[mysqld]'
end

# 初期パスワード設定
script 'Secure_Install' do
  interpreter 'bash'
  user 'root'
  not_if "mysql -u root -p#{node[:mysql][:password]} -e 'show databases'"
  code <<-EOL
    export Initial_PW=`head -n 1 /root/.mysql_secret |awk '{print $(NF - 0)}'`
    mysql -u root -p${Initial_PW} --connect-expired-password -e "SET PASSWORD FOR root@localhost=PASSWORD('#{node[:mysql][:password]}');"
    mysql -u root -p#{node[:mysql][:password]} -e "SET PASSWORD FOR root@'127.0.0.1'=PASSWORD('#{node[:mysql][:password]}');"
    mysql -u root -p#{node[:mysql][:password]} -e "FLUSH PRIVILEGES;"
  EOL
end

chef_gem 'mysql' do
  action :install
  subscribes :install, "package[mysql-devel]", :immediately
end

%w(cakephp cakephp_test).each do |db|
  execute 'mysql-create-database' do
    command "/usr/bin/mysqladmin -u root create #{db}"
    not_if do
      require 'rubygems'
      Gem.clear_paths
      require 'mysql'
      m = Mysql.new('localhost', 'root', '')
      m.list_dbs.include?(db)
    end
  end
end
