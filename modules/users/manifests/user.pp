define users::user(
  $uid,
  $gid,
  $groups,
  $comment = ''
) {

  require users

  group {
    $name:
      gid => $gid;
  }

  user {
    $name:
      uid => $uid,
      gid => $gid,
      comment => $comment,
      home => "/usr/home/${name}",
      shell => '/usr/local/bin/zsh',
      groups => $groups;
  }

  file {
    "/usr/home/${name}":
      ensure => directory,
      owner => $uid
      group => $gid
      mode => '0750';
  }

  pkg::install { 'zsh': }

}
