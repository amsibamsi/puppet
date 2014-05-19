define rclocal::config(
  $content = '',
  $source = '',
  $order = '50'
) {

  concatfile::part {
    "/etc/rc.local.d/$order.$name":
      content => $content,
      source => $source;
  }

}
