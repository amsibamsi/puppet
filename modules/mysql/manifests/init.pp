class mysql {

  package { "mysql-server": }

  file {
    "/var/db/mysql/my.cnf":
      source => "puppet:///modules/site-mysql/my.cnf/$hostname",
      require => Package["mysql-server"];
    "/etc/rc.conf.d/mysql":
      source => "puppet:///modules/mysql/mysql.rc.conf";
  }

  cron::job {
    "mysql-backup":
      source => "puppet:///modules/mysql/mysql-backup.cron",
      period => "daily";
  }

  # Bug: Puppet cannot read status from mysql-server init script
  service {
    "mysql-server":
      enable => true,
      require => Package["mysql-server"];
  }

}
