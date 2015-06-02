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
# [*targetfilename*]
#   The filename of the downloaded file. Overrides the filename provided by
#   the server.
# [*overwrite*]
#   Optional. Set to true if [*source*] is to be downloaded and the target
#   file overwritten, even if already present
#   Default is false.
# [*username*]
#   If authentications is required provide both username and password
# [*password*]
#   Optional only if username is not supplied
# [*timeout*]
#   Optional. Specifies the timeout duration. Default is 300 seconds.
#
# === Examples
#
#  pget{'Download puppet':
# source  => "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",
# target  => "C:/software",
#}
#
# pget{'Download puppet':
#   source  => "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",
#   target  => "C:/software",
#   username=> "myuser",
#   password=> "password1'
#}
# pget{'Download puppet':
#   source  => "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",
#   target  => "C:/software",
#   targetfilename => "my-puppet-install.msi",
#   username=> "myuser",
#   password=> "password1'
#}
#
#
# === Copyright
#
# Copyright 2013 Travis F, unless otherwise noted.
#
define pget (
  $source,                 #: the source file location, supports local files, http://, https://, ftp://
  $target         = undef, #: the target stage directory,
  $targetfilename = undef, #: desired filename, will be infered by the source if not defined.
  $username       = undef, #: Username to be passed
  $password       = undef, #: password needed,
  $timeout        = 300,   #: timeout
  $headerHash     = undef, #: additional has parameters for the download of the file, i.e. user-agent, Cookie
  $overwrite      = false, # : if the target file should be overwritten (if already present)
) {
  validate_string($source)
  validate_re($source, [
    '^s?ftp:',
    '^https?:',
    '^ftps?:',
    '^puppet:'])

  if $::operatingsystem != 'windows' {
    fail("Unsupported OS ${::operatingsystem}")
  }

  $_filename = $targetfilename  ? {
    undef   => pget_filename($source),
    default => $targetfilename,
  }

  $_target_file = "${target}/${_filename}"

  $_unlessClause = $overwrite ? {
    true    => '',
    default =>  "if(Test-Path -Path \"${_target_file}\" ){ exit 0 }else{exit 1}"
  }

  if $source =~ /^puppet/ {
    file{ "Download-${_filename}":
      ensure => file,
      path   => $_target_file,
      source => $source,
    }
  } else{
    validate_re($source,['^s?ftp:','^https?:','^ftps?:'])
    $_base_cmd = '$wc = New-Object System.Net.WebClient;'

    if $username or $password {
      validate_string($password)
      validate_re($password, ['(\w|\W)+'], 'Password must be supplied')
      validate_string($username)
      validate_re($username, ['(\w|\W)+'], 'Username must be supplied')
      $_pass_cmd = "\$wc.Credentials = New-Object System.Net.NetworkCredential('${username}','${password}');"
    } else{
      $_pass_cmd = ''
    }

    $_header_cmd =  $headerHash ? {
      undef   => '',
      default => build_header_cmd($headerHash)
    }

    $cmd = "${_base_cmd}${_header_cmd}${_pass_cmd}\$wc.DownloadFile('${source}','${_target_file}')"
    debug("About to execute command ${cmd}")
    exec{ "Download-${_filename}-to-${target}":
      provider => powershell,
      command  => $cmd,
      unless   => $_unlessClause,
      timeout  => $timeout,
    }
  }
}
