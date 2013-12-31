# == Class: pget
#
# Full description of class pget here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { pget:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
define pget (
  $source,              #: the source file location, supports local files, puppet://, http://, https://, ftp://
  $target      = undef, #: the target staging directory, if unspecified ${staging::path}/${caller_module_name}
  $username    = undef, #: https or ftp username
  $certificate = undef, #: https certificate file
  $password    = undef, #: https or ftp user password or https certificate password
  $timeout     = undef, #: the the time to wait for the file transfer to complete
  $subdir      = $caller_module_name){

  validate_string($source)
  validate_re($source,['^s?ftp:','^https?:','^ftps?:'])
  if $operatingsystem != 'windows'{
    fail("Unsupported OS ${operatingsystem}")
  }

  $filename = pget_filename($source)
  $target_file = "${target}/${filename}"
  if $password != undef or $username != undef {
    validate_string($password)
    validate_string($username)
    $cmd  = "\$wc = New-Object System.Net.WebClient;\$wc.Credentials = New-Object System.Net.NetworkCredential('${username}','${password}');\$wc.DownloadFile(${source},${target_file})"
  }else{
    $cmd = "\$wc = New-Object System.Net.WebClient; \$wc.DownloadFile('${source}','${target_file}')"
  }

  exec{"Download-${filename}":
    provider  => powershell,
    command   => $command,
  }





}
