# -*- mode: ruby -*-
# vi: set ft=ruby :
servers = [
    { name: 'master',
      hostname: 'puppet.master-josephlee.dev',
      box: 'precise64',
      box_url: 'http://files.vagrantup.com/precise64.box',
      network:{
        private_network: '192.168.33.10'
      },
      provision:{
          shell:
             %w(vagrant_config/shell/puppet.sh vagrant_config/shell/default.sh vagrant_config/shell/r10k.sh),
          puppet:{
            manifests_path: 'vagrant_config/puppet_master/manifests',
            manifest_file: 'default.pp',
            options: '--verbose --modulepath /home/vagrant/modules' }
      },
      sync_folder:{
          'puppet/manifests' => '/etc/puppet/manifests',
          'puppet/modules' => '/etc/puppet/modules',
          'puppet/hieradata' => '/etc/puppet/hieradata'
      }
    },
    { name: 'agent',
      hostname: 'puppet.agent-josephlee.dev',
      box: 'precise64',
      box_url: 'http://files.vagrantup.com/precise64.box',
      network:{
          private_network: '192.168.33.11'
      },
      provision:{
        shell:
          %w(vagrant_config/shell/puppet.sh vagrant_config/shell/default.sh),
        puppet:{
            manifests_path: 'vagrant_config/puppet_master/manifests',
            manifest_file: 'default.pp',
            options: '--verbose --modulepath /home/vagrant/modules' }
      },
    }
]

Vagrant.configure("2") do |config|
  servers.each do |server|
    config.vm.define server[:name] do |setup|
      setup.vm.hostname   = server[:hostname]
      setup.vm.box        = server[:box]
      setup.vm.box_url    = server[:box_url]

      # network setup for outside access
      setup.vm.network :private_network, ip: server[:network][:private_network]

      # provisioning box w/ shell and puppet if present
      server[:provision][:shell].each {|file| setup.vm.provision :shell, :path => file}
      server[:provision].has_key?(:puppet)
        setup.vm.provision :puppet do |config|
          config.manifests_path = server[:provision][:puppet][:manifests_path]
          config.manifest_file = server[:provision][:puppet][:manifest_file]
          config.options = server[:provision][:puppet][:options]
        end

      # sync folders to virtual server
      server[:sync_folder].each {|from, to| setup.vm.synced_folder from, to} if server.has_key?(:sync_folder)
    end
  end
end
