class base {

  file {
    "/srv":
      ensure => directory;
    "/etc/rc.conf.d":
      ensure => directory;
    "/usr/local":
      ensure => directory;
    "/usr/local/etc":
      ensure => directory;
    "/usr/local/etc/rc.d":
      ensure => directory;
    "/usr/local/src":
      ensure => directory;
    "/root":
      ensure => directory,
      owner => "root",
      group => "wheel",
      mode => "0700";
  }

}
