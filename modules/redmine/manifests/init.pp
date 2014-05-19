class redmine($host) {

  include lighttpd

  package { 'redmine': }

  exec {
    'redmine':
      command => '/bin/cp -a /usr/local/www/redmine /srv/web && /usr/sbin/chown -R root:wheel /srv/web/redmine',
      creates => '/srv/web/redmine',
      require => Package['redmine'];
  }

  file {
    '/srv/web/redmine/config/database.yml':
      source => 'puppet:///modules/redmine/database.yml',
      owner => 'root',
      group => 'www',
      mode => '0640',
      require => Exec['redmine'];
    '/srv/web/redmine/public/redmine.fcgi':
      source => 'puppet:///modules/redmine/fcgi',
      mode => '0755',
      require => Exec['redmine'];
    '/srv/web/redmine/tmp':
      ensure => directory,
      owner => 'www',
      group => 'www',
      mode => '0755',
      require => Exec['redmine'];
    '/srv/web/redmine/log':
      ensure => directory,
      owner => 'www',
      group => 'www',
      mode => '0755',
      require => Exec['redmine'];
    '/srv/web/redmine/public/plugin_assets':
      ensure => directory,
      owner => 'www',
      group => 'www',
      mode => '0755',
      require => Exec['redmine'];
    '/srv/web/redmine/files':
      ensure => directory,
      owner => 'www',
      group => 'www',
      mode => '0755',
      require => Exec['redmine'];
    '/var/db/redmine':
      ensure => directory,
      owner => 'www',
      group => 'www',
      mode => '0750';
    '/var/db/redmine/sqlite.db':
      ensure => present,
      owner => 'www',
      group => 'www',
      mode => '0640';
    '/usr/local/etc/lighttpd/host.d/redmine.conf':
      content => template('redmine/web.conf.erb'),
      notify => Service['lighttpd'];
    '/usr/local/etc/lighttpd/host-ssl.d/redmine.conf':
      content => template('redmine/web-ssl.conf.erb'),
      notify => Service['lighttpd'];
  }

}
