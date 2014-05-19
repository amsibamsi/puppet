class postgresql {

  package {
    'postgresql-server':
  }

  service {
    'postgresql':
      ensure => running,
      enable => true,
      require => Package['postgresql-server'];
  }

  file {
    '/usr/local/pgsql/data/postgresql.conf':
      source => 'puppet:///modules/postgresql/postgresql.conf',
      owner => 'pgsql',
      group => 'pgsql',
      mode => '0600',
      require => Package['postgresql-server'],
      notify => Service['postgresql'];
    '/usr/local/pgsql/data/pg_hba.conf':
      source => 'puppet:///modules/postgresql/pg_hba.conf',
      owner => 'pgsql',
      group => 'pgsql',
      mode => '0600',
      require => Package['postgresql-server'],
      notify => Service['postgresql'];
  }

}
