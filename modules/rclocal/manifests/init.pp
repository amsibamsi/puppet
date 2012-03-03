class rclocal {

  concatfile {
    "/etc/rc.local":
      dir => "/etc/rc.local.d";
  }

  rclocal::config {
    "comment":
      source => "puppet:///modules/base/comment",
      order => "00";
  }

}
