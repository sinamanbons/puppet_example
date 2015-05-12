node 'masternode'{
  include stdlib
}

node 'puppetagent.josephlee.dev' inherits masternode {
  include joseph-vagrant_puppet_node
}
