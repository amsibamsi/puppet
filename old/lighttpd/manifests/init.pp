class lighttpd {

  include bash
  include cert

  package { 'lighttpd': }

  service {
    'lighttpd':
      ensure => running,
      enable => true,
      require => [
        Package['lighttpd'],
        File['/usr/local/etc/lighttpd/lighttpd.conf'],
        File['/srv/web/sockets']
      ],
  }

  file {
    '/usr/local/etc/lighttpd':
      ensure => directory;
    '/usr/local/etc/lighttpd/lighttpd.conf':
      source => 'puppet:///modules/lighttpd/lighttpd.conf',
      notify => Service['lighttpd'];
    '/usr/local/etc/lighttpd/htdigestuser':
      source => 'puppet:///modules/lighttpd/htdigestuser',
      mode => '0755',
      require => Package['bash'];
    # certificate must be created by hand on ca
    '/usr/local/etc/lighttpd/genssl':
      content => template('lighttpd/genssl.erb'),
      mode => '0755';
    '/usr/local/etc/lighttpd/host.d':
      ensure => directory;
    '/usr/local/etc/lighttpd/host-ssl.d':
      ensure => directory;
    '/srv/web':
      ensure => directory,
      require => File['/srv'];
    '/srv/web/empty':
      ensure => directory;
    '/srv/web/empty/.keep':
      source => 'puppet:///modules/base/comment';
    '/srv/web/sockets':
      ensure => directory,
      owner => 'www',
      group => 'www';
  }

}
