define pkg::install {

  exec {
    "pkg_install_${name}":
      command => "pkg install ${name}",
      unless  => "pkg info -q ${name}";
  }

}
