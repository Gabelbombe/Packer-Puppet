class packer::timezone {

  file { '/etc/timezone':
    ensure  => present,
    content => "Europe/Berlin\n",
  }

  exec { 'reconfigure-tzdata':
          user => root,
          group => root,
          command => '/usr/sbin/dpkg-reconfigure --frontend noninteractive tzdata',
  }

  notify { 'timezone-changed':
          message => 'Timezone was updated to Europe/Berlin',
  }

  File['/etc/timezone'] -> Exec['reconfigure-tzdata'] -> Notify['timezone-changed']
}