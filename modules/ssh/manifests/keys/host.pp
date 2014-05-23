class ssh::keys::host {

  include site_ssh::keys::host

  file {
    '/etc/ssh/ssh_known_hosts':
      ensure => present,
      mode => '0644';
  }

}
