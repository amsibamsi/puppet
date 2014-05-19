class backup::server {

  include devd

  package { 'perl': }

  group {
    'backup':
      gid => '210';
  }

  user {
    'backup':
      uid => '210',
      gid => '210',
      comment => 'Backup data',
      home => '/backup/hosts',
      shell => '/bin/sh';
  }

  file {
    '/backup/hosts':
      ensure => directory,
      owner => 'backup',
      group => 'backup',
      mode => '0750';
    '/backup/hosts/.ssh':
      ensure => directory,
      owner => 'backup',
      group => 'backup',
      mode => '0700';
    '/backup/hosts/.ssh/authorized_keys':
      source => "puppet:///modules/site-backup/server/authorized_keys/${hostname}",
      owner => 'backup',
      group => 'backup';
    '/backup/hosts/.ssh/wrapper':
      source => 'puppet:///modules/backup/server/wrapper',
      owner => 'backup',
      group => 'backup',
      mode => '0755',
      require => Package['bash'];
    '/backup/hosts/.ssh/rrsync':
      source => 'puppet:///modules/backup/server/rrsync',
      owner => 'backup',
      group => 'backup',
      mode => '0755',
      require => Package['perl'];
    '/etc/devd/backup.conf':
      source => 'puppet:///modules/backup/server/devd.conf',
      notify => Service['devd'];
  }

}
