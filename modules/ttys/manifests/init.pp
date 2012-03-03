class ttys($vga = true) {

  concatfile {
    "/etc/ttys":
      dir => "/etc/ttys.d";
  }

  ttys::config {
    "comment":
      source => "puppet:///modules/base/comment",
      order => "00";
    "default":
      source => "puppet:///modules/ttys/default",
      order => "01";
  }

  if $vga == true {
    ttys::config {
      "vga":
        source => "puppet:///modules/ttys/vga",
        order => "99";
    }
  }

}
