class ssh {

  include ssh::server
  include ssh::client
  include ssh::keys::host

}
