class sercon {

  loader::config {
    "sercon":
      content => "\n# Serial console\nconsole=\"comconsole\"\ncomconsole_speed=\"115200\"\n";
  }

  ttys::config {
    "sercon":
      content => "\n# Serial console\nttyu0 \"/usr/libexec/getty std.115200\" vt100 on secure\n";
  }

}
