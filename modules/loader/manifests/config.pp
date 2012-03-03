define loader::config(
  $content = "",
  $source = "",
  $order = "50"
) {

  concatfile::part {
    "/boot/loader.conf.d/$order.$name":
      content => $content,
      source => $source;
  }

}
