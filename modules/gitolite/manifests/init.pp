class gitolite {

  require dirs::srv

  group {
    'git':
      gid => '100';
  }
  ->
  user {
    'git':
      uid => '100',
      gid => '100',
      comment => 'GIT version control',
      home => '/srv/git',
      shell => '/bin/sh';
  }
  ->
  file {
    '/srv/git':
      ensure => directory,
      owner => 'git',
      group => 'git',
      mode => '0750';
  }
  ->
  pkg::install { 'gitolite2': }
  ->
  ssh::userkey {
    'git':
      home => '/srv/git';
  }
  ->
  exec {
    'gitolite_setup':
      command => "su git /usr/local/bin/gl-setup /srv/git/.ssh/id_rsa.pub",
      creates => '/srv/git/.gitolite';
  }

}
