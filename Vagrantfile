# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

boxes = [
	{ :name => :nimbus, :ip => '192.168.33.100' },
#	{ :name => :supervisor1, :ip => '192.168.33.101' },
#	{ :name => :supervisor2, :ip => '192.168.33.102' },
#	{ :name => :zookeeper1, :ip => '192.168.33.201' }
]

	boxes.each do |opts|
		config.vm.define opts[:name] do |config|
			config.vm.box = "precise32"
			config.vm.box_url = "http://files.vagrantup.com/precise32.box"
			config.vm.network "private_network", ip: opts[:ip]
			config.vm.host_name = "%s" % opts[:name].to_s
			config.vm.host_name = opts[:name].to_s
			config.vm.provision "shell", inline: "echo Sync folder data to /vagrant_data."
			config.vm.synced_folder "./data", "/vagrant_data"
			config.vm.provision "shell", inline: "echo Copy hosts file."
			config.vm.provision "shell", inline: "cp -fv /vagrant_data/hosts /etc/hosts"
     	 		config.vm.provision "shell", inline: "wget http://apt-enterprise.puppetlabs.com/puppetlabs-enterprise-release-extras_1.0-2_all.deb"
			config.vm.provision "shell", inline: "sudo dpkg -i puppetlabs-enterprise-release-extras_1.0-2_all.deb"
			config.vm.provision "shell", inline: "apt-get update"
      			if File.exist?("data/jdk-6u45-linux-i586.bin") then
				config.vm.provision :puppet do |puppet|
					puppet.manifests_path = "manifest"
					puppet.manifest_file = "jdk.pp"
       				end
			end
		end
     	 
		config.vm.provision :puppet do |puppet|
			puppet.manifests_path = "manifest"
			puppet.manifest_file = "provisioningInit.pp"
		end
     	 
		# Ask puppet to do the provisioning now.
#		config.vm.provision "shell", inline: "puppet apply /tmp/storm-puppet/manifests/site.pp --verbose --modulepath=/tmp/storm-puppet/modules/ --debug"  
  	end
end
