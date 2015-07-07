include packer::sshd
include packer::networking
include packer::apache

unless $::provisioner == 'ec2' {
  include packer::vmtools
}