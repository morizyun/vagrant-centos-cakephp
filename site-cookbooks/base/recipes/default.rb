# スワップ領域作成
# 参考:http://qiita.com/naoya@github/items/2059e3755962e907315e
bash 'create swapfile' do
  user 'root'
  code <<-EOC
    dd if=/dev/zero of=/swap.img bs=1M count=1024 &&
    chmod 600 /swap.img
    mkswap /swap.img
  EOC
  only_if "test ! -f /swap.img -a `cat /proc/swaps | wc -l` -eq 1"
end

mount '/dev/null' do # swap file entry for fstab
  action :enable # cannot mount; only add to fstab
  device '/swap.img'
  fstype 'swap'
end

bash 'activate swap' do
  code 'swapon -ae'
  only_if "test `cat /proc/swaps | wc -l` -eq 1"
end


# iptables無効
service "iptables" do
	action [:stop, :disable]
end


# yum関係
%w{gcc make wget telnet readline-devel ncurses-devel gdbm-devel openssl-devel zlib-devel httpd vim ruby ruby-devel rdoc rubygems git}.each do |p|
	package p do
		action :install
	end
end

%w{phpMyAdmin php-mysql php-mcrypt}.each do |p|
  package p do
    action :install
    options '--enablerepo=epel'
  end
end

# httpd設定
service "httpd" do
	action [:start, :enable]
end

template "httpd.conf" do
	path "/etc/httpd/conf/httpd.conf"
	source "httpd.conf.erb"
	mode 0644
	notifies :restart, 'service[httpd]'
end

template "httpd.conf" do
  path "/etc/httpd/conf.d/phpMyAdmin.conf"
  source "phpMyAdmin.conf.erb"
  mode 0777
  notifies :restart, 'service[httpd]'
end

# yumファイルの加工
file '/etc/yum.conf' do
  _file = Chef::Util::FileEdit.new(path)
  _file.search_file_replace_line('exclude=kernel', "#exclude=kernel\n")
  content _file.send(:contents).join
  action :create
end.run_action(:create)