class dns {

  host {
    $fqdn:
      host_aliases => $hostname,
      ip => '127.0.0.1';
  }

}
