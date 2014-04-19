class localtime($zone) {

  file {
    '/etc/localtime':
      source => "/usr/share/zoneinfo/${zone}";
  }

}
