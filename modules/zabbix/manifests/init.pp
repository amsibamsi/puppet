class zabbix {

  include sysctl

  sysctl::config {
    "zabbix":
      content => "\n# Zabbix\nkern.ipc.shmall=16384\nkern.ipc.shmmax=67108864\n";
  }

  @file {
    "/var/run/zabbix":
      ensure => directory,
      owner => "zabbix",
      group => "zabbix",
      mode => "0750";
    "/var/log/zabbix":
      ensure => directory,
      owner => "zabbix",
      group => "zabbix",
      mode => "0750",
  }

}
