class updates::pkg($site) {

  cron::job {
    'updates-pkg':
      content => template('updates/pkg.cron.erb'),
      period => 'weekly';
  }

}
