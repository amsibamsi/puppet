class openvpn {

  include cert

  package { 'openvpn': }

  file {
    '/usr/local/etc/openvpn':
      ensure => directory;
    '/usr/local/etc/openvpn/openvpn.conf':
      content => template("site-openvpn/openvpn.conf/$hostname.erb"),
      notify => Service['openvpn'];
  }

  group {
    'openvpn':
      gid => '230';
  }

  user {
    'openvpn':
      uid => '230',
      gid => '230',
      comment => 'OpenVPN daemon',
      home => '/nonexistent',
      shell => '/usr/sbin/nologin';
  }

  service {
    'openvpn':
      ensure => running,
      enable => true,
      require => [
        Package['openvpn'],
        User['openvpn'],
        File['/usr/local/etc/openvpn/openvpn.conf'],
      ];
  }

}
