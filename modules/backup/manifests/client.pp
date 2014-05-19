class backup::client(
  $backup_remote = false
) {

  file {
    '/usr/local/etc/backup':
      ensure => directory,
      mode => '0750';
    '/usr/local/etc/backup/conf':
      source => "puppet:///modules/site-backup/client/conf/$hostname";
    '/usr/local/sbin/backup':
      source => 'puppet:///modules/backup/client/backup',
      mode => '0755',
      require => [
        Package['bash'],
        File['/usr/local/etc/backup/conf']
      ];
    '/usr/local/sbin/nodumps':
      source => 'puppet:///modules/backup/client/nodumps',
      mode => '0755',
      require => File['/usr/local/etc/backup/conf'];
  }

  cron::job {
    'backup':
      source => 'puppet:///modules/backup/client/backup.cron',
      period => 'hourly',
      order => '999';
    'nodumps':
      source => 'puppet:///modules/backup/client/nodumps.cron',
      period => 'weekly',
      notify => Exec['nodumps'];
  }

  exec {
    'nodumps':
      command => '/usr/local/sbin/nodumps',
      creates => '/usr/local/etc/backup/nodumps',
      refreshonly => true;
  }

  if $backup_remote {
   exec {
     'sshkey_backup':
       command => "ssh-keygen -b 4096 -t rsa -N '' -C 'backup@$hostname' -f /usr/local/etc/backup/key",
       creates => '/usr/local/etc/backup/key',
       require => File['/usr/local/etc/backup'];
    }
  }

}
