class portaudit {

  package::install {
    'portaudit':
  }

  cron::job {
    'portaudit':
      source => 'puppet:///modules/portaudit/portaudit.cron',
      period => 'daily';
  }

}
