class cron::cron inherits cron::periodic {

  file { '/etc/crontab':
    source => 'puppet:///modules/cron/cron/crontab',
    notify => Service['cron'],
  }

}
