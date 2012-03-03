class rcconf {

  file {
    "/etc/rc.conf":
      source => [
        "puppet:///modules/site-rcconf/rc.conf/$hostname",
        "puppet:///modules/base/comment"
      ];
  }

}
