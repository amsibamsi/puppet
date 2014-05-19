class swapfile($size = '512mb') {

  file {
    '/usr/swap':
      ensure => present,
      mode => '0600',
      owner => 'root',
      group => 'wheel';
    '/etc/rc.conf.d/addswap':
      content => '# Managed by Puppet\n\nswapfile=\'/usr/swap\'';
  }

  exec {
    'swapfile':
      command => "/bin/dd if=/dev/zero of=/usr/swap bs=${size} count=1",
      creates => '/usr/swap',
      before => File['/usr/swap'];
  }

}
