define sysctl::config(
  $content = "",
  $source = "",
  $order = "50"
) {

  concatfile::part {
    "/etc/sysctl.conf.d/$order.$name":
      content => $content,
      source => $source;
  }

}
