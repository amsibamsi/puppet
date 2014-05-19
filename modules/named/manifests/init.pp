class named($zones = '') {

  define zone_file() {
    file {
      "/etc/namedb/master/${name}.db":
        source => "puppet:///modules/site-named/zones/${name}.db",
        notify => Service['named'];
    }
  }

  service {
    'named':
      ensure => running,
      enable => true;
  }

  file {
    '/etc/rc.conf.d/named':
      source => 'puppet:///modules/named/named.rc.conf',
      notify => Service['named'],
      require => File['/etc/rc.conf.d'];
    '/etc/namedb/named.conf':
      source => "puppet:///modules/site-named/named.conf/${hostname}",
      notify => Service['named'];
    '/etc/namedb/rndc.key':
      ensure => present,
      owner => 'root',
      group => 'bind',
      mode => '0640',
      require => Exec['rndc_key'];
  }

  if $zones != '' {
    file {
      '/etc/namedb/master':
        ensure => directory;
    }
    zone_file { $zones: }
  }

  exec {
    'rndc_key':
      command => '/usr/sbin/rndc-confgen -a',
      creates => '/etc/namedb/rndc.key',
      notify => Service['named'];
  }

}
