class zabbix::client(
  $listen = '127.0.0.1',
  $server = '127.0.0.1'
) inherits zabbix {

  realize File['/var/run/zabbix'], File['/var/log/zabbix']

  package {
    'zabbix-agent':
      before => [
        File['/var/run/zabbix'],
        File['/var/log/zabbix'],
      ];
  }

  service {
    'zabbix_agentd':
      ensure => running,
      enable => true,
      require => [
        Package['zabbix-agent'],
        File['/usr/local/etc/zabbix/zabbix_agentd.conf'],
        File['/var/run/zabbix'],
        File['/var/log/zabbix'],
      ];
  }

  file {
    '/usr/local/etc/zabbix/zabbix_agentd.conf':
      content => template('zabbix/agentd.conf.erb'),
      require => Package['zabbix-agent'],
      notify => Service['zabbix_agentd'];
  }

}
