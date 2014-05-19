class ntp(
  $servers = ['0.pool.ntp.org',
              '1.pool.ntp.org',
              '2.pool.ntp.org',
              '3.pool.ntp.org'],
  $ntpdate_enable = false
) {

  file {
    '/etc/ntp.conf':
      content => template('ntp/ntp.conf.erb'),
      notify => Service['ntpd'];
  }

  service {
    'ntpd':
      ensure => running,
      enable => true,
      require => File['/etc/ntp.conf'];
  }

  if $ntpdate_enable {
    service {
      'ntpdate':
        enable => true,
        require => File['/etc/ntp.conf'];
    }
  }

}
