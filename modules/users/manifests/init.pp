class users {

  file {
    '/usr/home':
      ensure => directory;
    '/home':
      ensure => '/usr/home';
  }

}
