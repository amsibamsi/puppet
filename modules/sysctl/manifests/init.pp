class sysctl {

  concatfile {
    '/etc/sysctl.conf':
      dir => '/etc/sysctl.conf.d',
      notify => Exec['sysctl'];
  }

  sysctl::config {
    'comment':
      source => 'puppet:///modules/base/comment',
      order => '00';
    'generic':
      source => 'puppet:///modules/sysctl/generic',
      order => '02';
  }

  exec {
    'sysctl':
      command => '/etc/rc.d/sysctl start',
      refreshonly => true;
  }

}
