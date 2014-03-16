# phpインストール
%w{php php-devel php-mbstring php-mysql}.each do |p|
  package p do
    action :install
  end
end

# php設定
template "php.ini" do
  path "/etc/php.ini"
  source "php.ini.erb"
  mode 0644
  notifies :restart, 'service[httpd]'
end

