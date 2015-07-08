include packer::sshd
include packer::networking
include packer::apache
include packer::ntp

unless $::provisioner == 'ec2' {
  include packer::vmtools
}