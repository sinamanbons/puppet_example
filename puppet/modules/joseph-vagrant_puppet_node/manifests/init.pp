# == Class: puppet_node
#
# Full description of class puppet_node here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'puppet_node':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class joseph-vagrant_puppet_node {

  # creating a test file
  file { '/tmp/testing_puppet':
    content => "THIS IS A TEST 2\n",
  }

  #spinning up a new mysql server
  class { '::mysql::server': }

  mysql::db { 'mydb':
    user      => 'root',
    password  => 'password',
    host      => 'localhost',
  }

  mysql_user { 'root@localhost':
    ensure                   => 'present',
    max_connections_per_hour => '60',
    max_queries_per_hour     => '120',
    max_updates_per_hour     => '120',
    max_user_connections     => '10',
  }

  # granting access to all for user root
  mysql_grant { 'root@localhost/*.*':
    ensure      => 'present',
    options     => ['GRANT'],
    privileges  => ['ALL'],
    table       => '*.*',
    user        => 'root@localhost',
  }
}
