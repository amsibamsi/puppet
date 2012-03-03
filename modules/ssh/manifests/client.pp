class ssh::client {

  file {
    "/etc/ssh/ssh_config":
      source => [
        "puppet:///modules/site-ssh/ssh_config/$hostname",
        "puppet:///modules/ssh/ssh_config",
      ];
  }

}
