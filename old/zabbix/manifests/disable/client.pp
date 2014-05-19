class zabbix::disable::client inherits zabbix::disable {

  service {
    'zabbix_agentd':
      ensure => stopped;
  }

  file {
    '/etc/rc.conf.d/zabbix_agentd':
      ensure => absent;
  }

  package {
    'zabbix-agent':
      ensure => absent;
  }

}
