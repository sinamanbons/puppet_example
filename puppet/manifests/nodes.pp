node 'puppetagent.josephlee.dev' {
  file { '/tmp/testing_puppet':
    content => "THIS IS A TEST 2\n",
  }

  include joseph-mysql
}
