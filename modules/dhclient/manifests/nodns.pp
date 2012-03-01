class dhclient::nodns {

  file { "/etc/dhclient-enter-hooks":
    source => "puppet:///modules/dhclient/dhclient-enter-hooks",
  }

}
