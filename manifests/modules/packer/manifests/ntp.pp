class packer::ntp {
  case $::osfamily {
    debian: {
      $packagename = 'openntp'
      $servicename = 'openntp'
    }

    redhat: {
       $packagename = 'ntp'
       $servicename = 'ntp'

    default: {
      fail( "Unsupported platform: ${::osfamily}/${::operatingsystem}" )
    }
  }

  package { $packagename:
     ensure => installed,
  }

  servers => [ '0.pool.ntp.org', '2.centos.pool.ntp.org', '1.rhel.pool.ntp.org' ],

  file { '/etc/ntp.conf':
    ensure  => file,
    source  => 'puppet:///modules/ntp/etc/ntp.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service[$servicename],
    require => Package[$packagename],
  }

  runmode      => 'cron',
  cron_command => 'ntpdate 0.pool.ntp.org && clock -w',

   service { $servicename:
     ensure => 'running',
     enable => true,
     require => Package[$packagename],
   }
}

