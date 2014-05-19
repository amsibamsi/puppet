class openvpn::server inherits openvpn {

  exec {
    'dh-params':
      command => '/usr/bin/openssl dhparam -out /usr/local/etc/openvpn/dh.pem 1024',
      creates => '/usr/local/etc/openvpn/dh.pem',
      require => File['/usr/local/etc/openvpn'],
      before => Service['openvpn'];
  }

}
