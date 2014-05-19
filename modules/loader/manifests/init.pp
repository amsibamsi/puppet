class loader(
  $serial,
  $zfs
) {

  file {
    '/boot/loader.conf':
      content => template('loader/loader.conf.erb'),
      owner   => 'root',
      group   => 'wheel',
      mode    => '0644';
  }

}
