class ssh::server {

  service {
    "sshd":
      ensure => running,
      enable => true;
  }

  file {
    "/etc/ssh/sshd_config":
      source => [
        "puppet:///modules/site-ssh/sshd_config/$hostname",
        "puppet:///modules/ssh/sshd_config",
      ],
      notify => Service["sshd"];
  }

}
