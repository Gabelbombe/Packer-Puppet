#!/bin/bash -eux
echo -e '
Host *
  UseDNS no
  GSSAPIAuthentication no' >> /etc/ssh/sshd_config

service ssh reload

echo 'Speeding up SSH logon, disabling reverse DNS lookup'
