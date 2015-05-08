# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :master do |puppet_master_config|
    #setting up hostname: puppetmaster
    puppet_master_config.vm.hostname = "puppet.master-josephlee.dev"

    #Ubuntu/Debian box setup
    puppet_master_config.vm.box = "precise64"

    #vagrant box location if precise64 isn't already present
    puppet_master_config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    #setting up private network
    puppet_master_config.vm.network :private_network, ip: "192.168.33.10"

    #provisioning the puppet master
    puppet_master_config.vm.provision :shell, :path => "vagrant_config/shell/puppet.sh"
    puppet_master_config.vm.provision :shell, :path => "vagrant_config/shell/default.sh"
    puppet_master_config.vm.provision :shell, :path => "vagrant_config/shell/r10k.sh"

    #setting up puppet master w/ puppet provisioning
    puppet_master_config.vm.provision :puppet do |master|
      master.manifests_path = "vagrant_config/puppet_master/manifests"
      master.manifest_file  = "default.pp"
      master.options        = "--verbose --modulepath /home/vagrant/modules"
    end

    #syncing local folders to puppet master
    puppet_master_config.vm.synced_folder "puppet/manifests", "/etc/puppet/manifests"
    puppet_master_config.vm.synced_folder "puppet/modules", "/etc/puppet/modules"
    puppet_master_config.vm.synced_folder "puppet/hieradata", "/etc/puppet/hieradata"
  end

  config.vm.define :agent do |puppet_agent_config|
    # setting up hostname: puppetclient
    puppet_agent_config.vm.hostname = "puppetagent.josephlee.dev"

    #Ubuntu/Debian box setup
    puppet_agent_config.vm.box = "precise64"

    #vagrant box location if precise64 isn't already present
    puppet_agent_config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    #setting up private network
    puppet_agent_config.vm.network :private_network, ip: "192.168.33.11"

    #provisioning the puppet agent
    puppet_agent_config.vm.provision :shell, :path => "vagrant_config/shell/puppet.sh"
    puppet_agent_config.vm.provision :shell, :path => "vagrant_config/shell/default.sh"

    #setting up puppet agent w/ puppet provisioning
    puppet_agent_config.vm.provision :puppet do |agent|
      agent.manifests_path = "vagrant_config/puppet_agent/manifests"
      agent.manifest_file  = "default.pp"
      agent.options        = "--verbose --modulepath /home/vagrant/modules"
    end

  end
end
