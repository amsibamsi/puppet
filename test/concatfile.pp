Exec {
  path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
  logoutput => true,
}

file {
  '/tmp/ensure':
    content => 'ensure\n';
}

concatfile {
  '/tmp/concat':
    dir => '/tmp/concat.d';
}

concatfile::part {
  '/tmp/concat.d/01.content':
    content => 'content\n';
  '/tmp/concat.d/02.source':
    source => 'puppet:///modules/common/comment';
  '/tmp/concat.d/03.ensure':
    file => '/tmp/ensure',
    require => File['/tmp/ensure'];
}
