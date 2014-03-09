# app/tmpフォルダのパーミッション変更
bash 'change tmp permission' do
  user 'root'
  code <<-EOC
    chmod 777 #{node[:cakephp][:root]}/app/tmp
  EOC
end

template 'Config/core.php' do
  path "#{node[:cakephp][:root]}/app/Config/core.php"
  source 'core.php'
  mode 0644
end

template 'Config/bootstrap.php' do
  path "#{node[:cakephp][:root]}/app/Config/bootstrap.php"
  source 'bootstrap.php'
  mode 0644
end

template 'Config/database.php' do
  path "#{node[:cakephp][:root]}/app/Config/database.php"
  source 'database.php'
  mode 0644
end

template 'Controller/AppController.php' do
  path "#{node[:cakephp][:root]}/app/Controller/AppController.php"
  source 'AppController.php'
  mode 0644
end

