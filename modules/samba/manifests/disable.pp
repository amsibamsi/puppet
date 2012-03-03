class samba::disable {

  package {
    "samba34":
      ensure => absent;  
  }

  File {
    ensure => absent,
    force => true,
  }

  file { [
    "/usr/local/etc/smb.conf",
    "/usr/local/etc/samba",
    "/etc/rc.conf.d/samba",
  ]: }

  file {
    "/var/db/samba34":
      backup => false;
    "/var/log/samba34":
      backup => false;
  }

  group {
    "smbusers":
      ensure => absent;
  }

  user { 
    "smbuser":
      ensure => absent;
    "smbguest":
      ensure => absent;
    "smbadmin":
      ensure => absent;
  }

  service {
    "samba":
      ensure => stopped;
  }

}
