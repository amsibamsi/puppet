class portaudit {

  package {
    "portaudit":
      ensure => installed;
  }

  cron::job {
    "portaudit":
      source => "puppet:///modules/portaudit/portaudit.cron",
      period => "daily";
  }

}
