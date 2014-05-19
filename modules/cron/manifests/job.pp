define cron::job(
  $period,
  $content = '',
  $source = '',
  $order = '500'
) {

  $file = "/usr/local/etc/periodic/$period/$order.$name"

  File {
    mode => '0755',
    require => File["/usr/local/etc/periodic/$period"],
  }

  if $source == '' {
    file { $file:
      content => $content,
    }
  } else {
    file { $file:
      source => $source,
    }
  }

}
