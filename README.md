#`pget`
[![Build Status](https://travis-ci.org/cyberious/puppet-pget.png?branch=master)](https://travis-ci.org/cyberious/puppet-pget)

####Table of Contents
1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Reference](#reference)

##Overview
Tired of Unix dependencies in your Windows Environment to simply download web artifacts on your servers. 

##Module Description
Use `pget` it utilizes Powershell and removes other dependencies

### Begining with pget

    pget{'Download puppet':
        source  => 'http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi',
        target  => 'C:/software',
    }


##Usage

###Authentication of your request

    pget{'Download puppet':
            source   => 'http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi',
            target   => 'C:/software',
            username => 'myuser',
            password => 'password1'
    }


###Injecting cookie string
If you need to inject a cookie or other header information you can provide that info in the `headerHash` parameter

    pget {'Download requires Cookie and User-Agent':
    	source	    => 'http://crazyrobotsniffing.cookiecrying.com/fileIneed.exe',
    	target	    => 'd:/stage/',
    	headerHash  => {
    		'user-agent' =>'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko',
    		'Cookie'	 => 'I has cookie;'
    		}
    }

##Parameters

####`source`
The source file location, supports local files, http://, https://, ftp://, puppet://

####`target`
 No default value, the download target directory,

####`targetfilename` 
Desired filename, will be inferred by the source if not defined.

####`username`           
Username to be passed

####`password`
For usage when a credential needs to be set i.e. ftp

####`timeout`
How long we should allow the download to take before timing out and exiting process, default 300

####`headerHash` 
Hash containing header information such as user-agent, cookie and others, directly passed to #C
 
####`overwrite`
Whether to force the download even if file already exists

####`ingore_proxy`
Ignore the system proxy when set to `true`.

##Reference
[WebClient API](http://msdn.microsoft.com/en-us/library/system.net.webclient.headers(v=vs.110).aspx)
  
