class syscons($keymap = 'us.iso') {

  # Init script does not support status command
  service { 'syscons': }

  if $keymap == 'us.iso.pwdn' {
    file {
      "/usr/share/syscons/keymaps/${keymap}.kbd":
       source => "puppet:///modules/syscons/${keymap}.kbd",
       before => File['/etc/rc.conf.d/syscons'];
    }
  }

  file {
    '/etc/rc.conf.d/syscons':
      content => template('syscons/syscons.rc.conf.erb'),
      notify => Service['syscons'],
      require => File['/etc/rc.conf.d'];
  }

}
