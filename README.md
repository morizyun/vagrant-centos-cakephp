# Vagrantfile with CentOS 6.5/PHP 5.3/MySQL/Apache/CakePHP 2.4.6

_Description: Vagrantfile with CentOS 6.5/PHP 5.3/MySQL/Apache/CakePHP 2.4.6

## Project Setup

1. Download and install Vagrant http://www.vagrantup.com/

2. `vagrant plugin install vagrant-omnibus`

3. `vagrant plugin install vagrant-berkshelf`

4. `gem i berkshelf`

5. Download and install VirtualBox https://www.virtualbox.org/

6. `git clone https://github.com/morizyun/vagrant-centos-cakephp cakephp`

7. `cd cakephp`

8. `vagrant up`

9. Browsing `http://192.168.33.10/`

## Basic information

1. Sync Folder(Sever - Local) : `app/`

2. MySQL ROOT PASS : `cakepass`