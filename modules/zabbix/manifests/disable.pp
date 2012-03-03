class zabbix::disable {

  file {
    [
      "/var/run/zabbix",
      "/var/log/zabbix",
      "/usr/local/etc/zabbix",
    ]:
      ensure => absent,
      force => true;
  }

}
