class zabbix::server($host) inherits zabbix {

  include postgresql
  include lighttpd

  realize File['/var/run/zabbix'], File['/var/log/zabbix']

  package {
    'zabbix-server':
      before => [
        File['/var/run/zabbix'],
        File['/var/log/zabbix'],
      ];
    'zabbix-frontend':
      ;
  }

  service {
    'zabbix_server':
      enable => true,
      require => [
        Package['zabbix-server'],
        File['/var/run/zabbix'],
        File['/var/log/zabbix'],
      ];
  }

  file {
    '/usr/local/etc/zabbix/zabbix_server.conf':
      source => 'puppet:///modules/zabbix/server.conf',
      notify => Service['zabbix_server'];
    '/usr/local/etc/zabbix/.dbpass':
      owner => 'root',
      group => 'zabbix',
      mode => '0640',
      require => Package['zabbix-server'],
      notify => Service['zabbix_server'];
    '/srv/web/zabbix/conf/zabbix.conf.php':
      source => 'puppet:///modules/zabbix/zabbix.conf.php',
      mode => '0644', # bug?! puppet always wants to set 0640
      require => Exec['zabbix'];
    '/srv/web/zabbix/conf/.dbpass.php':
      owner => 'root',
      group => 'www',
      mode => '0640',
      require => [
        Exec['zabbix'],
        Package['lighttpd']
      ];
    '/usr/local/etc/lighttpd/host.d/zabbix.conf':
      content => template('zabbix/web.conf.erb'),
      notify => Service['lighttpd'];
    '/usr/local/etc/lighttpd/host-ssl.d/zabbix.conf':
      content => template('zabbix/web-ssl.conf.erb'),
      notify  => Service['lighttpd'];
  }

  exec {
    'zabbix':
      command => '/bin/cp -a /usr/local/www/zabbix /srv/web && /usr/sbin/chown -R root:wheel /srv/web/zabbix',
      creates => '/srv/web/zabbix',
      require => Package['zabbix-frontend'];
  }

}
