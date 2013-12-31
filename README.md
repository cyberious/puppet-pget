# Puppet-Pget
[![Build Status](https://travis-ci.org/cyberious/puppet-pget.png?branch=master)](https://travis-ci.org/cyberious/puppet-pget)

Tired of Unix dependencies in your Windows Environment to simply download web artifacts on your servers, use PGet it utilizes Powershell as and removes other dependencies

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
