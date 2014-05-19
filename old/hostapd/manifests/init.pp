class hostapd {

  service {
    'hostapd':
      ensure => running,
      enable => true;
  }

  file {
    '/etc/hostapd.conf':
      source => "puppet:///modules/site-hostapd/hostapd.conf/${hostname}",
      notify => Service['hostapd'];
    '/etc/hostapd.psk':
      ensure => present,
      mode => '0600';
  }

}
