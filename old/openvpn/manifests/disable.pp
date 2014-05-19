class openvpn::disable {

  file {
    '/usr/local/etc/openvpn':
      ensure => absent,
      force => true;
    '/etc/rc.conf.d/openvpn':
      ensure => absent,
      force => true;
  }

  group {
    'openvpn':
      ensure => absent;
  }

  user {
    'openvpn':
      ensure => absent;
  }

  service {
    'openvpn':
      ensure => stopped;
  }

}
