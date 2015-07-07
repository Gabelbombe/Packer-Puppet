class packer::apache inherits packer::apache::params {

  if ( $required_packages != undef ) {
    package { $required_packages:
      ensure => installed,
      before => File[ '/tmp/apache' ],
    }
  }

  file { '/tmp/apache':
    ensure => directory,
  }



}