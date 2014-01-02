# Puppet-Pget
[![Build Status](https://travis-ci.org/cyberious/puppet-pget.png?branch=master)](https://travis-ci.org/cyberious/puppet-pget)

Tired of Unix dependencies in your Windows Environment to simply download web artifacts on your servers. Use PGet it utilizes Powershell and removes other dependencies

    pget{'Download puppet':
        source  => "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",
        target  => "C:/software",
    }

    pget{'Download puppet':
            source  => "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",
            target  => "C:/software",
            username=> "myuser",
            password=> "password1'
    }

    pget {'Download requires Cookie and User-Agent':
    	source	=> "http://crazyrobotsniffing.cookiecrying.com/fileIneed.exe",
    	target	=> 'd:/stage/',
    	headerHash => {
    		'user-agent'=>'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko',
    		'Cookie'	=> 'I has cookie;'
    		}
    }