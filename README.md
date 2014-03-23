# Vagrantfile with CentOS 6.5/MySQL/Apache/phpMyAdmin/PHP 5.3/CakePHP 2.4.6

_Description: Vagrantfile with CentOS 6.5/Apache/MySQL/phpMyAdmin/PHP 5.3/CakePHP 2.4.6

## Project Setup

1. Download and install Vagrant http://www.vagrantup.com/

2. `vagrant plugin install vagrant-omnibus`

3. Download and install VirtualBox https://www.virtualbox.org/

4. `git clone https://github.com/morizyun/vagrant-centos-cakephp cakephp`

5. `cd cakephp`

6. `bundle install`

7. `bundle exec berks install --path site-cookbooks`

8. If you want to change host name, please change `config.vm.hostname = 'cakephp.dev'` in Vagrantfile

9. `vagrant up`

10. setting hosts add `192.168.33.10 cakephp.dev` (if you use Mac, the location of hosts file is `/etc/hosts`)

11. Browsing `http://cakephp.dev`

## Basic information

1. Sync Folder(Sever - Local) : `app/`

2. MySQL ROOT PASS : `cakepass`

3. phpMyAdimin URL : `http://cakephp.dev/phpMyAdmin` (user: `root`, pass: `cakepass`)