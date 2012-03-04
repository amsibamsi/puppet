class daapd($mp3_dir) {

  package { "mt-daapd": }

  file {
    "/usr/local/etc/mt-daapd.conf":
      content => template("daapd/mt-daapd.conf.erb"),
      owner => "root",
      group => "daapd",
      mode => "0640",
      notify => Service["mt-daapd"];
  }

  service {
    "mt-daapd":
      ensure => running,
      enable => true,
      require => Package["mt-daapd"];
  }

}
