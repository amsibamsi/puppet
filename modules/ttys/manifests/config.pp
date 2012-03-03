define ttys::config(
  $content = "",
  $source = "",
  $order = "50"
) {

  concatfile::part {
    "/etc/ttys.d/$order.$name":
      content => $content,
      source => $source;
  }

}
