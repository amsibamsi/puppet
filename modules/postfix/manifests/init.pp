class postfix($relay) {

  $etc_postfix = "/usr/local/etc/postfix"

  package { "postfix": }

  service {
    "postfix":
      ensure => running,
      enable => true,
      require => [
        Service["sendmail"],
        Package["postfix"]
      ];
    "sendmail":
      ensure => stopped;
  }

  exec {
    "postfix_aliases":
      command => "/usr/local/bin/newaliases",
      creates => "$etc_postfix/aliases.db",
      notify => Service["postfix"],
      require => [
        Package["postfix"],
        File["$etc_postfix/aliases"]
      ];
    "postfix_virtuals":
      command => "/usr/local/sbin/postmap $etc_postfix/virtuals",
      creates => "$etc_postfix/virtuals.db",
      notify => Service["postfix"],
      require => [
        Package["postfix"],
        File["$etc_postfix/virtuals"]
      ];
    "postfix_sasl":
      command => "/usr/local/sbin/postmap $etc_postfix/sasl",
      creates => "$etc_postfix/sasl.db",
      notify => Service["postfix"],
      require => [
        Package["postfix"],
        File["$etc_postfix/sasl"]
      ];
    "sendmail_clean":
      command => "/bin/rm -f /var/log/sendmail*",
      onlyif => "/bin/ls /var/log/sendmail*",
      require => Service["sendmail"];
  }

  file {
    $etc_postfix:
      ensure => directory;
    "$etc_postfix/main.cf":
      content => template("postfix/main.cf.erb"),
      notify => Service["postfix"];
    "$etc_postfix/aliases":
      source => "puppet:///modules/site-postfix/aliases",
      notify => Exec["postfix_aliases"];
    "$etc_postfix/virtuals":
      content => template("postfix/virtuals.erb"),
      notify => Exec["postfix_virtuals"];
    "$etc_postfix/sasl":
      owner => "root",
      group => "wheel",
      mode => "0600",
      notify => Exec["postfix_sasl"];
    "/etc/rc.conf.d/sendmail":
      source => "puppet:///modules/postfix/sendmail.rc.conf",
      before => Service["sendmail"];
    "/etc/mail/mailer.conf":
      source => "puppet:///modules/postfix/mailer.conf";
  }

  cron::job {
    "mail-heartbeat":
      period => "weekly",
      source => "puppet:///modules/postfix/heartbeat.cron";
  }

}
