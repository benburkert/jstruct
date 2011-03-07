dir = File.dirname(__FILE__)
require File.expand_path(File.join(dir, 'lib', 'jstruct', 'version'))

Gem::Specification.new do |s|
  s.name        = 'jstruct'
  s.version     = JStruct::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Ben Burkert'
  s.email       = 'ben@benburkert.com'
  s.homepage    = 'http://github.com/benburkert/jstruct'
  s.summary     = 'A simple libary for objects that dump & load JSON.'
  s.description = s.summary
  s.files       = Dir[File.join(dir, 'lib', '**', '*')] + %w[LICENSE]

  s.test_files = Dir[File.join(dir, 'spec', '**', '*')]

  s.add_dependency 'json'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~>2.0'
end
