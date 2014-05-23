class devfs {

  file {
    '/etc/devfs.conf':
      source => 'puppet:///modules/devfs/conf';
  }

}
