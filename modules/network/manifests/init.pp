class network {

  file {
    "/etc/rc.conf.d/network":
      source => "puppet:///modules/site-network/network.rc.conf/$hostname";
    "/etc/rc.conf.d/routing":
      source => [
        "puppet:///modules/site-network/routing.rc.conf/$hostname",
        "puppet:///modules/base/comment"
      ];
  }

}
