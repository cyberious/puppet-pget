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
  $headerHash  = {}, #: additional has parameters for the download of the file, i.e. user-agent, Cookie
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
    $cmd = build_download_cmd(hash(['source',$source,'target_file', $target_file,'header',$headerHash,'username',$username,'password',$password]))
  }else{
    $cmd = build_download_cmd(hash(['source',$source,'target_file', $target_file,'header',$headerHash]))
  }

  exec{"Download-${filename}":
    provider  => powershell,
    command   => $cmd,
  }





}
