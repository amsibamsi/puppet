class cron::anacron inherits cron::periodic {

  package { 'anacron': }

  service {
    'anacron':
      # will be started by cron repeatedly
      enable => false,
      require => Package['anacron'];
  }

  file { '/usr/local/etc/anacrontab':
    source => 'puppet:///modules/cron/anacron/anacrontab',
  }

  file { '/etc/crontab':
    source => 'puppet:///modules/cron/anacron/crontab',
  }

}
