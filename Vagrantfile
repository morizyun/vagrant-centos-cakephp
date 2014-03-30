# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'CentOS_6.5_i386'
  config.vm.box_url = 'http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-i386-v20140311.box'
  # Intel(R) Virtualization Technologyを有効化しないとVMで使えないため、初心者に厳しいからコメントアウト
  #config.vm.box = 'CentOS_6.5_x86_64'
  #config.vm.box_url = 'http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140110.box'

  config.vm.network :private_network, ip: '192.168.33.10'

  # cakephpを使うために必要
  config.vm.synced_folder './', '/vagrant', mount_options: ['dmode=777', 'fmode=666']

  # ホスト名
  config.vm.hostname = 'cakephp.dev'

  config.omnibus.chef_version = :latest

  #config.vm.provider :virtualbox do |vb|
  #  vb.gui = true
  #end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = './site-cookbooks'
    chef.add_recipe 'base'
    #chef.add_recipe 'mysql'
    chef.add_recipe 'php'
    chef.add_recipe 'cakephp'

    chef.run_list = %w(mysql::client mysql::server)

    chef.json = {
      httpd: {
        port: 80,
        docroot: '/vagrant/app'
      },
      php: {
        timezone: 'Asia/Tokyo'
      },
      mysql: {
        server_root_password: 'cakepass',
        server_repl_password: 'cakepass',
        server_debian_password: 'cakepass',
        bind_address: '127.0.0.1',
        remove_test_database: true,
        remove_anonymous_users: true,
      },
      cakephp: {
        root: '/vagrant/app'
      },
    }
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = './site-cookbooks'
    chef.run_list = %w(yum-epel base mysql::client mysql::server php database cakephp)

    chef.json = {
        httpd: {
            port: 80,
            docroot: '/vagrant/app',
            hostname: 'cakephp.dev'
        },
        php: {
            timezone: 'Asia/Tokyo'
        },
        mysql: {
            server_root_password: 'cakepass',
            server_repl_password: 'cakepass',
            server_debian_password: 'cakepass',
            bind_address: '127.0.0.1',
            remove_test_database: true,
            remove_anonymous_users: true,
        },
    }
    end
end
