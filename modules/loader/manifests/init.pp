class loader($options = []) {

  concatfile {
    "/boot/loader.conf":
      dir => "/boot/loader.conf.d";
  }

  loader::config {
    "comment":
      source => "puppet:///modules/base/comment",
      order => "00";
    "options":
      source => "puppet:///modules/loader/options",
      order => "01";
  }

  loader::config {
    "other":
      content => template("loader/other.erb"),
      order => "99";
  }

}
