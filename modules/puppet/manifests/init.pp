class puppet(
  $home = '/srv/puppet',
  $repo
) {

  require package::git

  file {
    '/usr/local/etc/puppet/puppet.conf':
      content => template('puppet/puppet.conf.erb');
    "$home":
      group => 'puppet',
      ensure => directory,
      mode => '0750';
    '/usr/local/sbin/ppssh':
      mode => '0755',
      content => template('puppet/ppssh.erb'),
      require => File["${home}/key"];
    '/usr/local/sbin/ppupdate':
      mode => '0755',
      content => template('puppet/ppupdate.erb'),
      require => File['/usr/local/sbin/ppssh'];
    '/usr/local/sbin/pprun':
      mode => '0755',
      content => template('puppet/pprun.erb');
    '/usr/local/sbin/ppon':
      mode => '0755',
      source => 'puppet:///modules/puppet/ppon';
    '/usr/local/sbin/ppoff':
      mode => '0755',
      source => 'puppet:///modules/puppet/ppoff';
    '/usr/local/sbin/ppstat':
      mode => '0755',
      source => 'puppet:///modules/puppet/ppstat';
  }

  ssh::key {
    'puppet':
      username => 'root',
      group    => 'wheel',
      dir      => $home,
      file     => 'key';
  }

  cron::job {
    'puppet':
      period => 'daily',
      source => 'puppet:///modules/puppet/puppet.cron';
  }

}
