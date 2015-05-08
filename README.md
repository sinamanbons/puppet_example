# EXAMPLE OF PUPPET ON VAGRANT

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Setup - The basics of getting started with Puppet Master and Agent](#setup)
    * [Requirements](#requirements)
    * [Spinning up new vagrant](#vagrant-up)
    * [Login to vagrant box](#login-to-vagrant-box)
    * [Start the puppet agent](#start-the-puppet-agent)
4. [Usage](#usage)
5. [TODO](#todo)

## Overview

This allows you a simple and easy way to have a puppet master and a puppet
agent spun up for testing purposes.

## Description

Puppet master has been set for external ip: 192.168.33.10

Puppet agent has been set for external ip: 192.168.33.11

Puppet dashboard is also present at 192.168.33.10:3000.

Puppet master is set for autosign-ing  anything that has the puppet
configuration server pointing to our puppet agent

## Setup

### Requirements

* Need to have install Vagrant - http://www.vagrantup.com/downloads.html
* Need to have some kind of VM running with Vagrant. VirtualBox is one possibility
  and can be downloaded free at - https://www.virtualbox.org/wiki/Downloads

### Vagrant Up

Once the repository has been cloned, you can go to the root directory of this repo and type

```sh
$ vagrant up
```

### Login to vagrant box
First find out the vagrants id's to ssh into them

```sh
$ vagrant global-status
```

The two vagrant boxes will have different name: master and agent. Copy the id's of each and ssh
into the vagrant boxes.

```sh
$ vagrant ssh $ID
```

### Start the puppet agent

SSH into the Vagrant box with the name 'agent'. Start the puppet agent

```sh
$ puppet agent -t
```

This will start the certification process and request the puppet master for signing. Since
we have puppet master on autosign, just verify if it is present on the Vagrant box with the
name 'master'. There should be two records present: puppet master and puppet agent

```sh
$ sudo puppet cert list -all
```

## Usage

The Vagrant box puppet master has its folder synced. So any changes to the following will
populate on the vagrant puppet master.

"puppet/manifests" -->  "/etc/puppet/manifests"

"puppet/modules" -->  "/etc/puppet/modules"

"puppet/hieradata" -->  "/etc/puppet/hieradata"

## TODO

Code refactoring

Planning on moving to Foreman instead of Puppet Dashboard

