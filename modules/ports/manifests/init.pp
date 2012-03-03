class ports {

  include portsnap

  cron::job {
    "ports-clean":
      source => "puppet:///modules/ports/ports-clean.cron",
      period => "weekly",
      order => "510",
  }

}
