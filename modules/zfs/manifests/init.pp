class zfs {

  cron::job {
    'zfs-backup':
      source => 'puppet:///modules/zfs/zfs-backup.cron',
      period => 'daily';
  }

  service {
    'zfs':
      enable => true;
    'zvol':
      enable => true;
  }

}
