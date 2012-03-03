class zfs {

  include loader
  include sysctl

  cron::job {
    "zfs-backup":
      source => "puppet:///modules/zfs/zfs-backup.cron",
      period => "daily";
  }

  service {
    "zfs":
      enable => true;
    "zvol":
      enable => true;
  }

  loader::config {
    "zfs":
      content => "\n# Load ZFS modules\nzfs_load=\"YES\"\n";
  }

}
