class fupdate {

  file {
    "/etc/freebsd-update.conf":
      source => "puppet:///modules/fupdate/freebsd-update.conf";
  }

  cron::job {
    "freebsd-update":
      source => "puppet:///modules/fupdate/freebsd-update.cron",
      period => "weekly";
  }

}
