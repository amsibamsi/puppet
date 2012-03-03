class localtime($zone) {

  file {
    "/etc/localtime":
      ensure => "/usr/share/zoneinfo/Europe/$zone",
  }

}
