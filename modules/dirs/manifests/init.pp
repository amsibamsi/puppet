class dirs::srv {
  file {
    '/srv':
      ensure => directory;
  }
}

class dirs::rcconfd {
  file {
    '/etc/rc.conf.d':
      ensure => directory;
  }
}

class dirs::local {
  file {
    '/usr/local':
      ensure => directory;
    '/usr/local/etc':
      ensure => directory;
    '/usr/local/etc/rc.d':
      ensure => directory;
    '/usr/local/src':
      ensure => directory;
  }
}

class dirs::root {
  file {
    '/root':
      ensure => directory,
      owner => 'root',
      group => 'wheel',
      mode => '0700';
  }
}
