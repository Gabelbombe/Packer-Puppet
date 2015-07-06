#!/bin/bash -eux

echo -e '
## Vagrant User
vagrant          ALL=(ALL) NOPASSWD:ALL
Defaults:vagrant !requiretty
Defaults         env_keep += "SSH_AUTH_SOCK"
' >> /etc/sudoers

sed -i -e 's/Defaults(.*)requiretty/# Defaults\1requiretty/g' \
       -e 's/Defaults(.*)!visible/# Defaults\1!visible/g'     /etc/sudoers

mkdir /home/vagrant/.ssh
wget --no-check-certificate \
    'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' \
    -O /home/vagrant/.ssh/authorized_keys

chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh
