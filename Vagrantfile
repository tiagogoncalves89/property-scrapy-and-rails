# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.define :webapp do |webapp_config|
	  webapp_config.vm.box = "precise32"
	  webapp_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
	  webapp_config.vm.network :hostonly, "192.168.30.10"
	  webapp_config.vm.customize ["modifyvm", :id, "--memory", 1024]
	  webapp_config.vm.share_folder 'v-root', '/project', 'webapp'
	  webapp_config.vm.share_folder 'vagrant', '/vagrant', 'vagrant'	  
	  webapp_config.vm.provision :puppet do |puppet|
	    puppet.manifests_path = "vagrant/manifests"
	    puppet.manifest_file  = "webapp.pp"
	  end	 
  end

  config.vm.define :crawler do |crawler_config|
	  crawler_config.vm.box = "precise32"
	  crawler_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
	  crawler_config.vm.network :hostonly, "192.168.30.11"
	  crawler_config.vm.customize ["modifyvm", :id, "--memory", 1024]
	  crawler_config.vm.share_folder 'v-root', '/project', 'crawler'
	  crawler_config.vm.share_folder 'vagrant', '/vagrant', 'vagrant'	  
	  crawler_config.vm.provision :puppet do |puppet|
	    puppet.manifests_path = "vagrant/manifests"
	    puppet.manifest_file  = "crawler.pp"
	  end	  
  end

end