class led {

  service {
    'led1':
      enable => true,
      require => File['/usr/local/etc/rc.d/led1'];
    'led2':
      enable => true,
      require => File['/usr/local/etc/rc.d/led2'];
  }

  file {
    '/usr/local/etc/rc.d/led1':
      source => 'puppet:///modules/led/led1.rc',
      mode => '0755';
    '/usr/local/etc/rc.d/led2':
      source => 'puppet:///modules/led/led2.rc',
      mode => '0755';
  }

}
