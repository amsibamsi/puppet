define ssh::userkey(
  $home
) {

  file {
    "${home}/.ssh":
      ensure  => directory,
      owner   => $name,
      group   => $name,
      mode    => '0700',
      before  => Exec["ssh_userkey_${name}"];
    "/${home}/.ssh/id_rsa":
      ensure   => present,
      owner    => $name,
      group    => $name,
      mode     => '0600',
      require  => Exec["ssh_userkey_${name}"];
    "/${home}/.ssh/id_rsa.pub":
      ensure   => present,
      owner    => $name,
      group    => $name,
      mode     => '0600',
      require  => Exec["ssh_userkey_${name}"];
  }

  exec {
    "ssh_userkey_${name}":
      command => "ssh-keygen -t rsa -b 4096 -N '' -f ${home}/.ssh/id_rsa",
      creates => "${home}/.ssh/id_rsa";
  }

}
