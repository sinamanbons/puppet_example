node default {

  host { 'puppetagent.josephlee.dev':
    ensure       => 'present',
    host_aliases => ['puppetagent'],
    ip           => '192.168.33.11',
    target       => '/etc/hosts',
  }

  host { 'puppet.master-josephlee.dev':
    ensure       => 'present',
    host_aliases => ['puppet'],
    ip           => '192.168.33.10',
    target       => '/etc/hosts',
  }

  package {'puppet':
    ensure  =>  latest,
    require => [Host['puppet.master-josephlee.dev'], Host['puppetagent.josephlee.dev']],
  }

  user { 'root':
    ensure => present,
    password => 'puppet',
  }

  file {'/etc/puppet/puppet.conf':
    ensure => present,
    owner => root,
    group => root,
    source => "/vagrant/puppet/modules/joseph-vagrant_puppet_master/files/puppet.conf",
    require => Package['puppet'],
  }

}
