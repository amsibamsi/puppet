define ssh::userkey(
  $home = '',
  $group = ''
) {

  if $home == '' {
    $real_home = "/home/${name}"
  } else {
    $real_home = $home
  }

  if $group == '' {
    $real_group = $name
  } else {
    $real_group = $group
  }

  file {
    "${real_home}/.ssh":
      ensure => directory,
      owner  => $name,
      group  => $real_group,
      mode   => '0700',
      before => Ssh::Key["user_${name}"];
  }

  ssh::key {
    "user_${name}":
      username => $name,
      group    => $real_group,
      dir      => "${real_home}/.ssh";
  }

}
