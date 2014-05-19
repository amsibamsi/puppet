class dir::srv {
  file {
    '/srv':
      ensure => directory;
  }
}

class dir::rcconfd {
  file {
    '/etc/rc.conf.d':
      ensure => directory;
  }
}

class dir::local {
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

class dir::root {
  file {
    '/root':
      ensure => directory,
      owner => 'root',
      group => 'wheel',
      mode => '0700';
  }
}
