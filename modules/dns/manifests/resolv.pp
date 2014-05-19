class dns::resolv(
  $search_path = [$domain],
  $servers = ['127.0.0.1']
){

  file {
    '/etc/resolv.conf':
      content => template('dns/resolv.conf.erb');
  }

}
