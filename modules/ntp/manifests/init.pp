class ntp(
  $server = "pool.ntp.org",
  $ntpdate_enable = false
) {

  file {
    "/etc/ntp.conf":
      content => template("ntp/ntp.conf.erb"),
      notify => Service["ntpd"];
  }

  service {
    "ntpd":
      ensure => running,
      enable => true,
      require => File["/etc/ntp.conf"];
  }

  if $ntpdate_enable {
    service {
      "ntpdate":
        enable => true,
        require => File["/etc/ntp.conf"];
    }
  }

}
