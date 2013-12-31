# == Class: pget
#
# Full description of class pget here.
#
# === Parameters
#
# Document parameters here.
#
# [*source*]
#   URL which you want to download from
# [*target*]
#   The stage directory where the file is to be downloaded
# [*username*]
#   If authentications is required provide both username and password
# [*password*]
#   Optional only if username is not supplied
#
# === Examples
#
#  pget{'Download puppet':
#source  => "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",
#target  => "C:/software",
#}

# pget{'Download puppet':
#   source  => "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",
#   target  => "C:/software",
#   username=> "myuser",
#   password=> "password1'
# }
#
#
# === Copyright
#
# Copyright 2013 Travis F, unless otherwise noted.
#
define pget (
  $source,              #: the source file location, supports local files, http://, https://, ftp://
  $target      = undef, #: the target stage directory
  $username    = undef, #: Username to be passed
  $password    = undef, #: password needed
  ){

  validate_string($source)
  validate_re($source,['^s?ftp:','^https?:','^ftps?:'])
  if $operatingsystem != 'windows'{
    fail("Unsupported OS ${operatingsystem}")
  }

  $filename = pget_filename($source)
  $target_file = "${target}/${filename}"
  if $password != undef or $username != undef {
    validate_string($password)
    validate_re($password,['(\w|\W)+'],"Password must be supplied")
    validate_string($username)
    validate_re($username,['(\w|\W)+'],"Username must be supplied")
    $cmd  = "\$wc = New-Object System.Net.WebClient;\$wc.Credentials = New-Object System.Net.NetworkCredential('${username}','${password}');\$wc.DownloadFile('${source}','${target_file}')"
  }else{
    $cmd = "\$wc = New-Object System.Net.WebClient; \$wc.DownloadFile('${source}','${target_file}')"
  }

  exec{"Download-${filename}":
    provider  => powershell,
    command   => $cmd,
  }





}
