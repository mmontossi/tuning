$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'tuning/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'tuning'
  s.version     = Tuning::VERSION
  s.authors     = ['Mattways']
  s.email       = ['contact@mattways.com']
  s.homepage    = 'https://github.com/mattways/tuning'
  s.summary     = 'Tuning for Rails.'
  s.description = 'Common used tools extracted into a gem.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', (ENV['RAILS_VERSION'] ? "~> #{ENV['RAILS_VERSION']}" : '>= 3.0.0')

  if RUBY_PLATFORM == 'java'
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
    s.add_development_dependency 'jruby-openssl'
  else
    s.add_development_dependency 'sqlite3'
  end
end
