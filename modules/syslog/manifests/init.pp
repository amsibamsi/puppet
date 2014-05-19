class syslog {

  package { 'rsyslog': }

  service {
    'rsyslogd':
      ensure => running,
      require => [
        Package['rsyslog'],
        File['/usr/local/etc/rsyslog.conf'],
        File['/etc/rc.conf.d/rsyslogd'],
        Exec['syslogd_stop'],
        Exec['newsyslog']
      ];
  }

  define remove_logfile() {
    exec {
      "log_clean_$name":
        command => "rm /var/log/$name*",
        onlyif => "ls /var/log/$name*",
        require => Exec['syslogd_stop'];
    }
  }

  remove_logfile { [
    'messages',
    'security',
    'auth.log',
    'maillog',
    'lpd-errs',
    'xferlog',
    'cron',
    'debug.log',
    'slip.log',
    'ppp.log'
  ]: }

  exec {
    'newsyslog':
      command => '/usr/sbin/newsyslog -C',
      refreshonly => true;
    'syslogd_stop':
      command => '/etc/rc.d/syslogd forcestop',
      onlyif => '/etc/rc.d/syslogd onestatus';
  }

  file {
    '/etc/rc.conf.d/syslogd':
      source => 'puppet:///modules/syslog/syslogd.rc.conf';
    '/usr/local/etc/rsyslog.conf':
      source => 'puppet:///modules/syslog/rsyslog.conf',
      notify => Service['rsyslogd'];
    '/etc/newsyslog.conf':
      source => 'puppet:///modules/syslog/newsyslog.conf',
      notify => Exec['newsyslog'];
    '/etc/rc.conf.d/rsyslogd':
      source => 'puppet:///modules/syslog/rsyslogd.rc.conf',
      notify => Service['rsyslogd'];
  }

  cron::job {
    'newsyslog':
      source => 'puppet:///modules/syslog/newsyslog.cron',
      period => 'daily';
  }

}
