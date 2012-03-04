class makeconf {

  concatfile {
    "/etc/make.conf":
      dir => "/etc/make.conf.d";
  }

  makeconf::config {
    "comment":
      source => "puppet:///modules/base/comment",
      order => "00";
    "generic":
      source => "puppet:///modules/makeconf/generic",
      order => "01";
  }

}
