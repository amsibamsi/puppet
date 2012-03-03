class gitosis {

  group {
    "git":
      gid => "100";
  }

  user {
    "git":
      uid => "100",
      gid => "100",
      comment => "GIT version control",
      home => "/srv/git",
      shell => "/bin/sh";
  }

  file {
    "/srv/git":
      ensure => directory,
      owner => "git",
      group => "git",
      mode => "0750",
      require => [
        User["git"],
        File["/srv"]
      ];
  }

  # Package will create user as well if it's not yet there,
  # but we will force our own specs for it
  package {
    "py26-gitosis":
      require => User["git"];
  }

}
