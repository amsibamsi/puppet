class postfix(
  $relay,
  $root_forward = '',
) {

  $etc_postfix = '/usr/local/etc/postfix'

  package::install {
    'postfix':
  }

  service {
    'postfix':
      ensure => running,
      enable => true,
      require => [
        Service['sendmail'],
        Package::Install['postfix']
      ];
    'sendmail':
      ensure => stopped;
  }

  exec {
    'postfix_aliases':
      command => '/usr/local/bin/newaliases',
      creates => "${etc_postfix}/aliases.db",
      notify => Service['postfix'],
      require => [
        Package::Install['postfix'],
        File["${etc_postfix}/aliases"]
      ];
    'postfix_virtuals':
      command => "/usr/local/sbin/postmap ${etc_postfix}/virtuals",
      creates => "${etc_postfix}/virtuals.db",
      notify => Service['postfix'],
      require => [
        Package::Install['postfix'],
        File["${etc_postfix}/virtuals"]
      ];
    'postfix_sasl':
      command => "/usr/local/sbin/postmap ${etc_postfix}/sasl",
      creates => "${etc_postfix}/sasl.db",
      notify => Service['postfix'],
      require => [
        Package::Install['postfix'],
        File["${etc_postfix}/sasl"]
      ];
    'sendmail_clean':
      command => '/bin/rm -f /var/log/sendmail*',
      onlyif => '/bin/ls /var/log/sendmail*',
      require => Service['sendmail'];
    'postfix_checkpwd':
      command => "/usr/bin/grep -F '${relay}' ${etc_postfix}/sasl";
  }

  file {
    $etc_postfix:
      ensure => directory;
    "${etc_postfix}/main.cf":
      content => template('postfix/main.cf.erb'),
      notify => Service['postfix'];
    "${etc_postfix}/aliases":
      source => 'puppet:///modules/postfix/aliases',
      notify => Exec['postfix_aliases'];
    "${etc_postfix}/virtuals":
      content => template('postfix/virtuals.erb'),
      notify => Exec['postfix_virtuals'];
    "${etc_postfix}/sasl":
      source  => 'puppet:///modules/postfix/sasl.template',
      owner   => 'root',
      group   => 'wheel',
      mode    => '0600',
      replace => false,
      notify  => Exec['postfix_sasl'];
    '/etc/rc.conf.d/sendmail':
      source => 'puppet:///modules/postfix/sendmail.rc.conf',
      before => Service['sendmail'];
    '/etc/mail/mailer.conf':
      source => 'puppet:///modules/postfix/mailer.conf';
  }

  unless $root_forward == '' {
    file {
      '/root/.forward':
        content => $root_forward;
    }
  }

  cron::job {
    'mail-heartbeat':
      period => 'weekly',
      source => 'puppet:///modules/postfix/heartbeat.cron';
  }

}
