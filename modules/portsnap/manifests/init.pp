class portsnap {

  cron::job {
    "portsnap":
      period => "weekly",
      source => "puppet:///modules/portsnap/portsnap.cron",
      order => "500";
  }

}
