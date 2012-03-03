define makeconf::config(
  $content = "",
  $source = "",
  $order = "50"
) {

  concatfile::part {
    "/etc/make.conf.d/$order.$name":
      content => $content,
      source => $source;
  }

}
