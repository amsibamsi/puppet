class users {

  include site-users

  file {
    "/usr/home":
      ensure => directory;
    "/home":
      ensure => "/usr/home",
      require => File["/usr/home"];
  }

}
