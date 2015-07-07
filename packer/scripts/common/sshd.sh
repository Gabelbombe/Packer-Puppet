#!/bin/bash -eux
echo -e '
Host *
  UseDNS no
  GSSAPIAuthentication no' >> /etc/ssh/sshd_config

echo 'Speeding up SSH logon, disabling reverse DNS lookup'
