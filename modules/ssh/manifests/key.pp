define ssh::key(
  $username,
  $group = '',
  $dir,
  $file = ''
) {

  if $group == '' {
    $real_group = $username
  } else {
    $real_group = $group
  }

  if $file == '' {
    $real_file = 'id_rsa'
  } else {
    $real_file = $file
  }

  exec {
    "ssh_userkey_${name}":
      command => "ssh-keygen -t rsa -b 4096 -N '' -f ${real_file}",
      creates => "${real_file}";
  }

  file {
    "${real_file}":
      ensure   => present,
      owner    => $username,
      group    => $real_group,
      mode     => '0600',
      require  => Exec["ssh_userkey_${name}"];
    "${real_file}.pub":
      ensure   => present,
      owner    => $username,
      group    => $real_group,
      mode     => '0600',
      require  => Exec["ssh_userkey_${name}"];
  }

}
