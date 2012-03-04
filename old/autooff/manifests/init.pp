class autooff(
  $autooff_schedules => [
    "..-(23|0[0-4])-..-..-[1-4,7]",
    "..-0[1-4]-..-..-[56]"
  ]
){

  include bash

  cron::job {
    "autooff":
      period => "shortly",
      content => template("autooff/autooff.cron.erb"),
      order => "999";
  }

}
