class updates::ports {

  cron::job {
    "updates-ports":
      source => "puppet:///modules/updates/ports.cron",
      period => "weekly",
      order => "520";
  }

}
