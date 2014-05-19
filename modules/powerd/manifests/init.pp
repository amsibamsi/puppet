class powerd {

  require dir::rcconfd

  file {
    "/etc/rc.conf.d/powerd":
      source => "puppet:///modules/powerd/powerd.rc.conf";
  }

}
