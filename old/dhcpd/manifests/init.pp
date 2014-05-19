class dhcpd($ifaces => 'private') {

  package { 'isc-dhcp31-server': }

  service {
    'isc-dhcpd':
      ensure => running,
      enable => true;
  }

  file {
    '/usr/local/etc/dhcp':
      ensure => directory;
    '/usr/local/etc/dhcp/hosts.conf':
      source => "puppet:///modules/site-dhcpd/hosts.conf/$hostname",
      notify => Service['isc-dhcpd'];
    '/usr/local/etc/dhcp/dhcpd.conf':
      source => "puppet:///modules/site-dhcpd/dhcpd.conf/$hostname",
      notify => Service['isc-dhcpd'];
    '/etc/rc.conf.d/dhcpd':
      content => template('dhcpd/dhcpd.rc.conf.erb'),
      notify => Service['isc-dhcpd'];
  }

}
