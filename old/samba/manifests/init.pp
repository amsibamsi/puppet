class samba {

  package { "samba34": }

  file {
    "/usr/local/etc/smb.conf":
      source => [
        "puppet:///modules/site-samba/smb.conf/$hostname"
      ],
      notify => Service["samba"];
    "/usr/local/etc/samba":
      ensure => directory;
    "/usr/local/etc/samba/smbusers":
      source => [
        "puppet:///modules/site-samba/smbusers/$hostname",
        "puppet:///modules/base/comment"
      ],
      require => Package["samba34"],
      notify => Service["samba"];
  }

  group {
    "smbusers":
      gid => "200";
  }

  user { 
    "smbuser":
      uid => "200",
      gid => "200",
      comment => "Owner of samba files",
      home => "/nonexistent",
      shell => "/usr/sbin/nologin",
      require => Group["smbusers"];
    "smbguest":
      uid => "201",
      gid => "200",
      comment => "Samba guest",
      home => "/nonexistent",
      shell => "/usr/sbin/nologin",
      require => Group["smbusers"];
    "smbadmin":
      uid => "202",
      gid => "200",
      comment => "Samba admin",
      home => "/nonexistent",
      shell => "/usr/sbin/nologin",
      require => Group["smbusers"];
  }

  service {
    "samba":
      ensure => running,
      enable => true,
      require => [
        Package["samba34"],
        File["/usr/local/etc/smb.conf"],
        File["/usr/local/etc/samba/smbusers"],
        User["smbuser"],
        User["smbguest"],
        User["smbadmin"],
      ],
  }

}
