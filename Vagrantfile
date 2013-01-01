# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.define :web_db do |web_db_config|
	  web_db_config.vm.box = "precise32"
	  web_db_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
	  web_db_config.vm.network :hostonly, "192.168.30.10"
	  web_db_config.vm.provision :puppet do |puppet|
	    puppet.manifests_path = "vagrant/manifests"
	    puppet.manifest_file  = "web_db_base.pp"
	  end	 
  end

  config.vm.define :crawler do |crawler_config|
	  crawler_config.vm.box = "precise32"
	  crawler_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
	  crawler_config.vm.network :hostonly, "192.168.30.11"
	  crawler_config.vm.customize ["modifyvm", :id, "--memory", 1024]
	  crawler_config.vm.provision :puppet do |puppet|
	    puppet.manifests_path = "vagrant/manifests"
	    puppet.manifest_file  = "crawler_base.pp"
	  end	  
  end

end