node default {

  host { 'puppet.master-josephlee.dev':
    ensure       => 'present',
    host_aliases => ['puppet'],
    ip           => '192.168.33.10',
    target       => '/etc/hosts',
  }

  package {'puppetmaster':
    ensure  =>  latest,
    require => Host['puppet.master-josephlee.dev'],
  }

# Configure puppetdb and its underlying database
  class { 'puppetdb':
    listen_address => '0.0.0.0',
    require => Package['puppetmaster'],
    puppetdb_version => latest,
  }

# Configure the puppet master to use puppetdb
  class { 'puppetdb::master::config': }

  class {'dashboard':
    dashboard_site    => $fqdn,
    dashboard_port    => '3000',
    require           => Package["puppetmaster"],
  }

  file {'/etc/puppet/puppet.conf':
    ensure => present,
    owner => root,
    group => root,
    source => "/vagrant/puppet/modules/joseph-vagrant_puppet_master/files/puppet.conf",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard']],
    require => Package['puppetmaster'],
  }

  file {'/etc/puppet/autosign.conf':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/puppet/modules/joseph-vagrant_puppet_master/files/autosign.conf",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard']],
    require => Package['puppetmaster'],
  }

  file {'/etc/puppet/auth.conf':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/puppet/modules/joseph-vagrant_puppet_master/files/auth.conf",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard']],
    require => Package['puppetmaster'],
  }

  file {'/etc/puppet/fileserver.conf':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/puppet/modules/joseph-vagrant_puppet_master/files/fileserver.conf",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard']],
    require => Package['puppetmaster'],
  }

  file {'/etc/puppet/modules':
    mode  => '0644',
    recurse => true,
  }

  file { '/etc/puppet/hiera.yaml':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/puppet/modules/joseph-vagrant_puppet_master/files/hiera.yaml",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard']],
  }

  file { '/etc/puppet/hieradata':
    mode => '0644',
    recurse => true,
  }

}