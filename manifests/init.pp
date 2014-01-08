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
  $password    = undef, #: password needed,
  $headerHash  = undef, #: additional has parameters for the download of the file, i.e. user-agent, Cookie
  ){

  validate_string($source)
  validate_re($source,['^s?ftp:','^https?:','^ftps?:'])
  if $operatingsystem != 'windows'{
    fail("Unsupported OS ${operatingsystem}")
  }

  $filename = pget_filename($source)
  $target_file = "${target}/${filename}"

  $base_cmd = "\$wc = New-Object System.Net.WebClient;"
  if $username or $password {
    validate_string($password)
    validate_re($password,['(\w|\W)+'],"Password must be supplied")
    validate_string($username)
    validate_re($username,['(\w|\W)+'],"Username must be supplied")
    $pass_cmd = "\$wc.Credentials = New-Object System.Net.NetworkCredential('${username}','${password}');"
  }

  if $headerHash {
    $header_cmd = build_header_cmd($headerHash)
  }
  $cmd = "${base_cmd}${header_cmd}${pass_cmd}\$wc.DownloadFile('${source}','${target_file}')"

  exec{"Download-${filename}":
    provider  => powershell,
    command   => $cmd,
    unless  => "if(Test-Path -Path \"${target_file}\" ){ exit 0 }else{exit 1}"
  }

}
