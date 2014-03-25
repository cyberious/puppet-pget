source "https://rubygems.org"

group :development, :test do
  gem 'rake'
  gem 'rspec'
  gem 'mocha'
  gem 'puppetlabs_spec_helper', :require => false
  gem 'rspec-puppet', :require => false
  gem 'puppet-lint'
  gem 'rspec-system'
  gem 'rspec-system-puppet'
  gem 'rspec-system-serverspec'
  gem 'serverspec'
  gem 'beaker'
  gem 'beaker-rspec'
end

facterversion = ENV['GEM_FACTER_VERSION']
if facterversion
  gem 'facter', facterversion
else
  gem 'facter', :require => false
end

ENV['GEM_PUPPET_VERSION'] ||= ENV['PUPPET_GEM_VERSION']
puppetversion = ENV['GEM_PUPPET_VERSION']
if puppetversion
  gem 'puppet', puppetversion
else
  gem 'puppet', :require => false
end