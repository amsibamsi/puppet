class package::audit {

  cron::job {
    'pkgaudit':
      source => 'puppet:///modules/package/pkgaudit.cron',
      period => 'daily';
  }

}
