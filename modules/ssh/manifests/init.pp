class ssh {

  include ssh::keys::host
  include site-ssh::keys::user
  include ssh::server
  include ssh::client

}
