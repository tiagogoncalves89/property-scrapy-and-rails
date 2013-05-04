# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :crawler do |crawler_config|
    crawler_config.vm.box = "precise32"
    crawler_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
    crawler_config.vm.network :private_network, ip: "192.168.33.11"
    crawler_config.vm.synced_folder ".vagrant/files", "/tmp/vagrant-puppet/files"
    crawler_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = ".vagrant/manifests"
      puppet.manifest_file  = "crawler.pp"
    end
  end

  config.vm.define :webapp do |webapp_config|
    webapp_config.vm.box = "precise32"
    webapp_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
    webapp_config.vm.network :private_network, ip: "192.168.33.10"
    webapp_config.vm.synced_folder ".vagrant/files", "/tmp/vagrant-puppet/files"
    webapp_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = ".vagrant/manifests"
      puppet.manifest_file = "webapp.pp"
    end
  end

end