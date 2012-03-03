class cert(
  $dir = "/etc/ssl"
) {

  $cert_dir = "$dir/certs"
  $key_dir = "$dir/keys"
  $key = "$key_dir/localhost.pem"
  $cert = "$cert_dir/localhost.pem"
  $subj = "$cert_dir/localhost.subj"
  $csr = "$cert_dir/localhost.csr"
  $ca_cert = "$cert_dir/ca.pem"
  $ca_subj = "$cert_dir/ca.subj"
  $key_length = "4096"

  file {
    $dir:
      ensure => directory,
      mode   => "0755",
      owner  => "root",
      group  => "0";
    $cert_dir:
      ensure => directory;
      mode   => "0755",
      owner  => "root",
      group  => "0";
    $key_dir:
      ensure => directory;
      mode   => "0700",
      owner  => "root",
      group  => "0";
    $subj:
      source => "puppet:///modules/site-cert/host.subj";
    $ca_cert:
      source => "puppet:///modules/site-cert/ca.pem";
    $ca_subj:
      source => "puppet:///modules/site-cert/ca.subj";
    $key:
      mode => "0600",
      require => Exec["ssl_host_key"];
  }

  exec {
    "ssl_host_key":
      command => "openssl genrsa -out $key $key_length",
      creates => $key,
      require => File[$key_dir],
      notify => Exec["ssl_host_csr"];
    "ssl_host_csr":
      command => "openssl req -new -key $key -subj \"`cat $subj`\" -out $csr",
      refreshonly => true,
      require => File[$subj];
  }

}
