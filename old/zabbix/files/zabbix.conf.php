<?php

# Managed by Puppet.

global $DB;

require(".dbpass.php");

$DB["TYPE"]   = "POSTGRESQL";
$DB["SERVER"]   = "localhost";
$DB["PORT"]   = "5432";
$DB["DATABASE"]   = "zabbix";
$DB["USER"]   = "zabbix";
$ZBX_SERVER   = "localhost";
$ZBX_SERVER_PORT  = "10051";


$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;

?>
