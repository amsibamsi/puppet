class alix {

  service {
    'alixreset':
      enable => true,
      require => File['/usr/local/etc/rc.d/alixreset'];
  }

  file {
    '/usr/local/src/alixswitch.c':
      source => 'puppet:///modules/alix/alixswitch.c',
      notify => Exec['alixswitch-compile'];
    '/usr/local/sbin/alixreset':
      source => 'puppet:///modules/alix/alixreset',
      mode => '0755',
      require => Exec['alixswitch-compile'];
    '/usr/local/etc/rc.d/alixreset':
      source => 'puppet:///modules/alix/alixreset.rc',
      mode => '0755',
      require => File['/usr/local/sbin/alixreset'];
  }

  exec {
    'alixswitch-compile':
      command => '/usr/bin/gcc -o /usr/local/sbin/alixswitch /usr/local/src/alixswitch.c',
      creates => '/usr/local/sbin/alixswitch';
  }

}
