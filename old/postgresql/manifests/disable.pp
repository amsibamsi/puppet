class postgresql::disable {

  file {
    "/usr/local/pgsql":
      ensure => absent,
      force => true;
  }

  service {
    "postgresql":
      ensure => stopped;
  }

  package {
    "postgresql-server":
      ensure => absent;
  }

  group {
    "pgsql":
      ensure => absent;
  }

  user {
    "pgsql":
      ensure => absent;
  }

}
