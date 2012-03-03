class ssh::keys::host {

  include site-ssh::keys::host

  file {
    "/etc/ssh/ssh_known_hosts":
      ensure => present,
      mode => "0644";
  }

}
