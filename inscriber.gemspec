require File.expand_path('../lib/inscriber/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'inscriber'
  s.version      = Inscriber::VERSION
  s.authors      = ['Ian Florentino']
  s.email        = ['ian@pryntcases.com']
  s.homepage     = 'https://github.com/prynt/inscriber'
  s.summary      = 'A tool for downloading localized data from your database and creating a locale file for translations'
  s.description  = "#{s.summary}"
  s.license      = 'MIT'

  s.files        = Dir['{lib,spec}/**/*']
  s.require_path = 'lib'
  s.platform     = Gem::Platform::RUBY

  s.add_dependency 'sequel', '~> 4.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'sqlite3'
end
