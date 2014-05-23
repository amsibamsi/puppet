class firewall {

  service {
    'pf':
      enable => true,
      ensure => running,
      restart => '/etc/rc.d/pf reload';
  }

  file {
    '/etc/pf.conf':
      source => "puppet:///modules/site-firewall/pf.conf/${hostname}",
      notify => Service['pf'];
  }

}
