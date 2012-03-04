class daapd::disable {

  package {
    "mt-daapd":
      ensure => absent;
  }

  File {
    ensure => absent,
    force => true,
  }

  file { [
    "/usr/local/etc/mt-daapd.conf",
    "/etc/rc.conf.d/mtdaapd",
  ]: }

  file {
    "/var/db/mt-daapd":
      backup => false;
  }

  service {
    "mt-daapd":
      ensure => stopped;
  }

}
