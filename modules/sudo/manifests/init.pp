class sudo {

  package::install { 'sudo': }

  file {
    '/usr/local/etc/sudoers':
      source => 'puppet:///modules/sudo/sudoers',
      mode => '0440';
  }

}
