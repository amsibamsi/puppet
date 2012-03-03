class zfs::boot($root = "zroot") {

  include loader

  loader::config {
    "zfsboot":
      content => "\n# Boot from ZFS root\nvfs.root.mountfrom=\"zfs:$root\"\n";
  }

}
