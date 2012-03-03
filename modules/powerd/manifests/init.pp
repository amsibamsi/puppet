class powerd {

  file {
    "/etc/rc.conf.d/powerd":
      source => "puppet:///modules/powerd/powerd.rc.conf",
      require => File["/etc/rc.conf.d"];
  }

}
