class smart(
  $devices = "DEVICESCAN",
  $device_options = []
) {

  package { "smartmontools": }

  file {
    "/usr/local/etc/smartd.conf":
      content => template("smart/smartd.conf.erb"),
      notify => Service["smartd"];
  }

  service {
    "smartd":
      ensure => running,
      enable => true,
      require => [
        Package["smartmontools"],
        File["/usr/local/etc/smartd.conf"]
      ];
  }

  cron::job {
    "smart-short":
      content => template("smart/smart-short.cron.erb"),
      period => "weekly";
    "smart-long":
      content => template("smart/smart-long.cron.erb"),
      period => "monthly";
  }

}
