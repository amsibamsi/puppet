define package::install {

  exec {
    "package_install_${name}":
      command => "pkg install -y ${name}",
      unless  => "pkg info -q ${name}";
  }

}
