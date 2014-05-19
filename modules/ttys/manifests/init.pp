class ttys(
  $vga,
  $serial
) {

  file {
    '/etc/ttys':
      content => template('ttys/ttys.erb'),
      owner   => 'root',
      group   => 'wheel',
      mode    => '0644';
  }

}
