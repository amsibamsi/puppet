class zabbix::disable::server inherits zabbix::disable {

  service {
    "zabbix_server":
      ensure => stopped;
  }

  file {
    [
      "/srv/web/zabbix",
      "/usr/local/etc/lighttpd/host.d/zabbix.conf",
      "/usr/local/etc/lighttpd/host-ssl.d/zabbix.conf",
    ]:
      ensure => absent,
      force => true,
      notify => Service["lighttpd"];
    "/etc/rc.conf.d/zabbix_server":
      ensure => absent,
      force => true;
  }

  package {
    ["zabbix-server", "zabbix-frontend"]:
      ensure => absent;
  }

}
