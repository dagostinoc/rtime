# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

task :test => :run_specs

GemHadar do
  name        'rtime'
  author      'Florian Frank'
  email       'flori@ping.de'
  homepage    "http://flori.github.com/#{name}"
  summary     'Application to time processes'
  description 'Application to time processes in Ruby and Redis'
  spec_dir    'spec'
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', 'coverage', '.rvmrc', '.AppleDouble'
  readme      'README.md'
  title       "#{name.camelize} -- Time processes in Ruby and Redis"
  licenses    << 'Apache-2.0'

  dependency 'tins', '~>1.0'
  dependency 'redis'
  dependency 'json'
  development_dependency 'rake'
  development_dependency 'simplecov'
  development_dependency 'rspec'
  development_dependency 'byebug'
end
