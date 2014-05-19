class cron::periodic {

  service {
    'cron':
      ensure => running,
      enable => true;
  }

  file {
    '/usr/local/etc/periodic':
      ensure => directory;
    '/etc/periodic.conf':
      source => 'puppet:///modules/cron/periodic.conf';
    '/etc/periodic.conf.local':
      source => [
        "puppet:///modules/site/cron/periodic.conf.local/${hostname}",
        'puppet:///modules/cron/periodic.conf.local'
      ];
    '/usr/local/etc/periodic/shortly':
      ensure => directory;
    '/usr/local/etc/periodic/hourly':
      ensure => directory;
    '/usr/local/etc/periodic/daily':
      ensure => directory;
    '/usr/local/etc/periodic/weekly':
      ensure => directory;
    '/usr/local/etc/periodic/monthly':
      ensure => directory;
    '/usr/local/etc/periodic/security':
      ensure => directory;
  }

  cron::job {
    'adjkerntz':
      source => 'puppet:///modules/cron/jobs/adjkerntz',
      period => 'shortly';
    'save-entropy':
      source => 'puppet:///modules/cron/jobs/save-entropy',
      period => 'shortly';
    'gpart-backup':
      source => 'puppet:///modules/cron/jobs/gpart-backup',
      period => 'daily';
  }

}
