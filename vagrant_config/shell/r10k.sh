#!/usr/bin/env bash
#
# This installs r10k and pulls the modules for continued installation
#
# We cannot handle failures gracefully here
set -e

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

apt-get update >/dev/null

echo "Installing r10k..."
gem install -y r10k  >/dev/null

echo "Running r10k to fetch modules for puppet provisioner..."
cp /vagrant/vagrant_config/puppet_master/Puppetfile .
r10k puppetfile install

