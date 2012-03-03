class fsnapshot {

  package { "freebsd-snapshot": }

  cron::job {
    "snapshot-hourly":
      source => "puppet:///modules/fsnapshot/hourly.cron",
      period => "hourly",
      order => "999";
    "snapshot-daily":
      source => "puppet:///modules/fsnapshot/daily.cron",
      period => "daily",
      order => "999";
    "snapshot-weekly":
      source => "puppet:///modules/fsnapshot/weekly.cron",
      period => "weekly",
      order => "999";
  }

}
